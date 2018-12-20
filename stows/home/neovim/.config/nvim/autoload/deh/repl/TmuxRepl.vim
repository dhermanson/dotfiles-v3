function! g:deh#repl#TmuxRepl#new(prefix, command)
  let obj = {}

  " Private members
  let obj._command = a:command
  let obj._session_name = <SID>CreateTmuxSessionName(a:prefix)

  " Public Functions
  function! obj.is_running()
    call system("tmux has-session -t=" . self._session_name)
    return v:shell_error == 0
  endfunction

  function! obj.start()
    call self.stop()
    call <SID>CreateNewTmuxPane(self._command, self._session_name)
  endfunction

  function! obj.stop()
    call <SID>KillTmuxPane(self._session_name)
  endfunction

  function! obj.send_current_line()
    call self._ensure_running()
    call <SID>SendLineToTmuxPane(line('.'), self._session_name)
  endfunction

  function! obj.send_selected_lines()
    call self._ensure_running()
    call <SID>SendLinesToTmuxPane(line("'<"), line("'>"), self._session_name)
  endfunction

  " Private Functions
  function! obj._ensure_running()
    if self.is_running() == 0
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
  silent call tbone#write_command(0, a:line, a:line, 1, a:pane)
endfunction

function! s:SendSymbolToTmuxPane(symbol, pane)
  let l:cmd = "tmux send-keys -t " . a:pane . " '" . a:symbol . "' Enter"
  call system(l:cmd)
endfunction

function! s:KillTmuxPane(pane)
  call system("tmux kill-pane -t " . a:pane)
endfunction

function! s:CreateTmuxSessionName(prefix)
  return a:prefix . systemlist("date +%s")[0]
endfunction

function! s:CreateNewTmuxPane(command, session_name)
  call system("urxvt -c ". getcwd() . " -e tmux new -s " . a:session_name . " "  . a:command . " &")
endfunction
