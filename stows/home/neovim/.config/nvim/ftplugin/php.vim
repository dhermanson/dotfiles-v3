if (exists("b:did_ftplugin"))
  finish
endif
let b:did_ftplugin = 1

let s:cpo_save = &cpo
set cpo&vim

setlocal shiftwidth=2 tabstop=2 expandtab softtabstop=2
setlocal tags=~/.language-ctags/php/tags,.ctags-php,.ctags-php-vendor
