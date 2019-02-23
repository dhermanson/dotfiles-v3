function! g:deh#repl#TmuxRepl#new(prefix, command)
  let obj = {}

  " Private members
  let obj._command = a:command
  let obj._session_name = <SID>CreateTmuxSessionName(a:prefix)
  let obj._pane = obj._session_name

  " Public Functions
  function! obj.has_running_session()
    call system("tmux has-session -t=" . self._session_name)
    return v:shell_error == 0
  endfunction

  function! obj.start()
    " call self.stop()
    "
    if self.has_running_session()
      call self._add_pane_to_existing_session()
    else
      call self._create_new_session()
    endif
    " call <SID>CreateNewTmuxPane(self._command, self._session_name)
  endfunction

  function! obj._add_pane_to_existing_session()
    call system("tmux neww -t " . self._session_name . " "  . self._command . " &")
    sleep 300m
    " let l:old_pane_id = self._pane
    let self._pane = systemlist('tmux list-panes -t ' . self._session_name . ' -F "#{pane_id}"')[-1]
    " call systemlist('tmux kill-pane -t ' . l:old_pane_id)
  endfunction

  function! obj._create_new_session()
    call system("urxvt -name urxvtreplfloat -c ". getcwd() . " -e tmux new -s " . self._session_name . " "  . self._command . " &")
    " call system("urxvt -name urxvtreplfloat -geometry 100x30 -c ". getcwd() . " -e tmux new -s " . self._session_name . " "  . self._command . " &")
    sleep 300m
    let self._pane = systemlist('tmux list-panes -t ' . self._session_name . ' -F "#{pane_id}"')[0]
  endfunction

  function! obj.stop()
    call <SID>KillTmuxPane(self._pane)
  endfunction

  function! obj.restart()
    if self.has_running_session()
      let l:old_pane_id = self._pane
      call self._add_pane_to_existing_session()
      call <SID>KillTmuxPane(l:old_pane_id)
    endif
  endfunction

  function! obj.stop_session()
    call <SID>KillTmuxSession(self._session_name)
  endfunction

  function! obj.send_current_line()
    " call self._ensure_running()
    call <SID>SendLineToTmuxPane(line('.'), self._pane)
  endfunction

  function! obj.send_selected_lines()
    " call self._ensure_running()
    call <SID>SendLinesToTmuxPane(line("'<"), line("'>"), self._pane)
  endfunction

  function! obj.handle_repl_selection(result)
    let l:pane_id = split(a:result)[0]
    let self._pane = l:pane_id
  endfunction

  function! obj.select()
    call fzf#run({
          \ 'source':  'tmux list-panes -as -F "#{pane_id} #{session_name}:#{window_index}:#{window_name} (pane #{pane_index})"',
          \ 'options': '--ansi -i -n 1 --with-nth 2,3,4 --preview-window="up:75%" --preview="tmux capture-pane -p -t {1} | tail -n 30"',
          \ 'sink': { result -> self.handle_repl_selection(result) }})
  endfunction

  " Private Functions
  function! obj._ensure_running()
    if self.has_running_session() == 0
      throw "repl not running"
    endif
  endfunction

  return obj

endfunction

function! s:SendLinesToTmuxPane(line1, line2, pane)
  let l:sleep = 0
  if a:line2 - a:line1 > 10
    let l:sleep = 1
  endif

  for line in range(a:line1, a:line2)
    silent call <SID>SendLineToTmuxPane(line, a:pane)
    if l:sleep == 1
      sleep 1m
    endif
  endfor
endfunction

function! s:SendLineToTmuxPane(line, pane)

  if &ft == 'python'
    if getline(a:line) =~ "^\\s*$"
      " here, i must check the indent level of the next non-empty line, and
      " write that leading whitespace
      silent call s:WriteCommand(0, a:line, a:line, 1, a:pane)
    else
      silent call s:WriteCommand(0, a:line, a:line, 1, a:pane)
    endif
  else
    silent call tbone#write_command(0, a:line, a:line, 1, a:pane)
  endif
endfunction

function! s:SendSymbolToTmuxPane(symbol, pane)
  let l:cmd = "tmux send-keys -t " . a:pane . " '" . a:symbol . "' Enter"
  call system(l:cmd)
endfunction

function! s:KillTmuxPane(pane)
  call system("tmux kill-pane -t " . a:pane)
endfunction

function! s:KillTmuxSession(session)
  call system("tmux kill-session -t " . a:session)
endfunction

function! s:CreateTmuxSessionName(prefix)
  return a:prefix . systemlist("date +%s")[0]
endfunction

function! s:CreateNewTmuxPane(command, session_name)
  call system("urxvt -name urxvtreplfloat -geometry 100x30 -c ". getcwd() . " -e tmux new -s " . a:session_name . " "  . a:command . " &")
  " let self._pane = self._session_name
  " call system("urxvt -name urxvtreplowndesktop -fn 'xft:Monaco:style=Regular:size=22:antialias=true:hinting=true' -c ". getcwd() . " -e tmux new -s " . a:session_name . " "  . a:command . " &")
endfunction

" this is basically tpope's function, exception i'm not trimming leading
" whitespace when calculating keys
function! s:WriteCommand(bang, line1, line2, count, ...) abort
  let target = a:0 ? a:1 : get(g:, 'tbone_write_pane', '')
  if empty(target)
    return 'echoerr '.string('Target pane required')
  endif

  " let keys = join(filter(map(
  "       \ getline(a:line1, a:line2),
  "       \ 'substitute(v:val,"^\\s*","","")'),
  "       \ "!empty(v:val)"),
  "       \ "\r")
  " let keys = join(filter(map(
  "       \ getline(a:line1, a:line2),
  "       \ 'substitute(v:val,"","","")'),
  "       \ "!empty(v:val)"),
  "       \ "\r")
  let keys = join(filter(
        \ getline(a:line1, a:line2),
        \ "!empty(v:val)"),
        \ "\r")
  if a:count > 0
    let keys = get(g:, 'tbone_write_initialization', '').keys."\r"
  endif

  try
    let pane_id = tbone#send_keys(target, keys)
    let g:tbone_write_pane = pane_id
    echo len(keys).' keys sent to '.pane_id
    return ''
  catch /.*/
    return 'echoerr '.string(v:exception)
  endtry
endfunction
