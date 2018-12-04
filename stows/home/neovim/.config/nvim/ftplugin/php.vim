if (exists("b:did_ftplugin"))
  finish
endif
let b:did_ftplugin = 1

let s:cpo_save = &cpo
set cpo&vim

setlocal shiftwidth=2 tabstop=2 expandtab softtabstop=2
setlocal tags=~/tags/php/phpstorm-stubs/tags,.ctags-php,.ctags-php-vendor



" vim-php-namespace
inoremap <buffer> <localleader>a <Esc>:call IPhpInsertUse()<CR>
nnoremap <buffer> <localleader>a :call PhpInsertUse()<CR>
inoremap <buffer> <localleader>q <Esc>:call IPhpExpandClass()<CR>
nnoremap <buffer> <localleader>q :call PhpExpandClass()<CR>
inoremap <buffer> <localleader>.s <Esc>:call PhpSortUse()<CR>
nnoremap <buffer> <localleader>.s :call PhpSortUse()<CR>
