if exists('g:deh#repl#loaded')
  finish
endif

let g:deh#repl#loaded = 1

" b:current_syntax

if !exists("g:deh#repl#repls")
  let g:deh#repl#repls = {}
endif

function! s:is_lang_defined(lang)
  return has_key(g:deh#repl#repls, a:lang)
endfunction

function! g:deh#repl#start()
  if !<SID>is_lang_defined(b:current_syntax)
    echom "no repl defined for current language"
    return
  endif

  let repl = g:deh#repl#repls[b:current_syntax]
  call repl.start()
endfunction

function! g:deh#repl#stop()
  if !<SID>is_lang_defined(b:current_syntax)
    echom "no repl defined for current language"
    return
  endif

  let repl = g:deh#repl#repls[b:current_syntax]
  call repl.stop()
endfunction

function! g:deh#repl#send_current_line()
  if !<SID>is_lang_defined(b:current_syntax)
    echom "no repl defined for current language"
    return
  endif

  let repl = g:deh#repl#repls[b:current_syntax]
  call repl.send_current_line()
endfunction

function! g:deh#repl#send_selected_lines()
  if !<SID>is_lang_defined(b:current_syntax)
    echom "no repl defined for current language"
    return
  endif

  let repl = g:deh#repl#repls[b:current_syntax]
  call repl.send_selected_lines()
endfunction


" TODO: make an command that kills all repls on vim exit


" TODO: make the TmuxRepl object have a method to test if session exists
"       `tmux has-session -t=session-name`
