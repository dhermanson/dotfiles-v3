if exists('g:deh#repl#loaded')
  finish
endif

let g:deh#repl#loaded = 1

" b:current_syntax

if !exists("g:deh#repl#map")
  let g:deh#repl#map = {
        \   "ruby": {
        \     "cmd": "pry"
        \   }
        \ }
endif

let g:deh#repl#repls = {}

function! s:is_lang_defined(lang)
  return has_key(g:deh#repl#map, a:lang)
endfunction

function! s:get_running_repl(lang)
  if !<SID>is_lang_defined(a:lang)
    throw a:lang . " has no repl definition"
  endif

  " TODO: get the repl object from the map
  try
    let repl = g:deh#repl#repls[a:lang]
    return repl
  catch
    return -1
  endtry

endtry
  let repl = deh#repl#repls[a:lang]
  " TODO: if 
  return -1 " if not found
endfunction

function! s:create_repl(lang)
  if !<SID>is_lang_defined(a:lang)
    throw a:lang . " has no repl definition"
  endif

  let def = g:deh#repl#map[a:lang]

  " TODO: 
  let obj = { "lang": a:lang }

  let obj.send_line = { line -> " TODO: send the line" }

  return obj
endfunction

" TODO: add a function that makes sure TMUX pane is actually running

function! s:get_or_create_repl(lang)
  let repl = <SID>get_running_repl(a:lang)

  if repl == -1
    return <SID>create_repl(a:lang)
  else
    return repl
  endif
endfunction

" TODO: b:current_syntax gets the current file type
function! g:deh#repl#send_line(line, language)
  " TODO: make the get_or_create_repl call return the repl
  let repl = <SID>get_or_create_repl(a:language)
  " call <SID>get_or_create_repl(b:current_syntax)
  " TODO: grab repl for lang and call send_line method
endfunction


" TODO: make an command that kills all repls on vim exit


" TODO: make the TmuxRepl object have a method to test if session exists
"       `tmux has-session -t=session-name`
