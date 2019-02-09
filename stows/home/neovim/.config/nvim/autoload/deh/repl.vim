if exists('g:deh#repl#loaded')
  finish
endif

let g:deh#repl#loaded = 1

if !exists("g:deh#repl#repls")
  let g:deh#repl#repls = {}
endif

function! s:repl_is_defined_for(lang)
  if has_key(g:deh#repl#repls, a:lang)
    return 1
  else
    echom "no repl defined for " . a:lang
    return 0
  endif
endfunction

function! g:deh#repl#start()
  if <SID>repl_is_defined_for(b:current_syntax)
    let repl = g:deh#repl#repls[b:current_syntax]
    call repl.start()
  endif

endfunction

function! g:deh#repl#stop()
  if <SID>repl_is_defined_for(b:current_syntax)
    let repl = g:deh#repl#repls[b:current_syntax]
    call repl.stop()
  endif
endfunction

function! g:deh#repl#send_current_line()
  if <SID>repl_is_defined_for(b:current_syntax)
    let repl = g:deh#repl#repls[b:current_syntax]
    call repl.send_current_line()
  endif

endfunction

function! g:deh#repl#send_selected_lines()
  let curline = line("'>")
  execute 'normal mz'
  if <SID>repl_is_defined_for(b:current_syntax)

    let repl = g:deh#repl#repls[b:current_syntax]
    call repl.send_selected_lines()
  endif
  " execute 'normal `z'
  exe 'normal ' l:curline . 'G$'
endfunction


" TODO: make an command that kills all repls on vim exit
