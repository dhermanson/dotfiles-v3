if (exists("b:did_ftplugin"))
  finish
endif
let b:did_ftplugin = 1

let s:cpo_save = &cpo
set cpo&vim

" nnoremap <silent> <buffer> <localleader>c :call jobstart('plantuml -tpng ' . expand('%') . ' 2>/dev/null')<CR>
nnoremap <silent> <buffer> <localleader>c :silent !plantuml -tpng % 2>/dev/null &<CR>
" nnoremap <silent> <buffer> <localleader>o :call jobstart('xdg-open ' . expand('%:r') . '.png 2>/dev/null')<CR>
nnoremap <silent> <buffer> <localleader>o :call system('xdg-open ' . expand('%:r') . '.png 2>/dev/null &')<CR>
