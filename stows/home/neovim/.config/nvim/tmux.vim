function! SendLinesToTmuxPane(line1, line2, pane)
  let l:sleep = 0
  if a:line2 - a:line1 > 10
    let l:sleep = 1
  endif

  for line in range(a:line1, a:line2)
    silent call SendLineToTmuxPane(line, a:pane)
    if l:sleep == 1
      sleep 1m
    endif
  endfor
endfunction

function! SendLineToTmuxPane(line, pane)
  silent call tbone#write_command(0, a:line, a:line, 1, a:pane)
endfunction

function! SendSymbolToTmuxPane(symbol, pane)
  let l:cmd = "tmux send-keys -t " . a:pane . " '" . a:symbol . "' Enter"
  call system(l:cmd)
endfunction

function! KillTmuxPane(pane)
  call system("tmux kill-pane -t " . a:pane)
endfunction

function! CreateTmuxSessionName(prefix)
  return a:prefix . systemlist("uuidgen")[0]
endfunction

function! CreateNewTmuxPane(command, session_name)
  call system("urxvt -c ". getcwd() . " -e tmux new -s " . a:session_name . " "  . a:command . " &")
endfunction
