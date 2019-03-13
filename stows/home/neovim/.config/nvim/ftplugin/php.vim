if (exists("b:did_ftplugin"))
  finish
endif
let b:did_ftplugin = 1

let s:cpo_save = &cpo
set cpo&vim

setlocal shiftwidth=2 tabstop=2 expandtab softtabstop=2
setlocal tags=~/tags/php/phpstorm-stubs/tags,.ctags-php,.ctags-php-vendor



" vim-php-namespace
inoremap <silent> <buffer> <localleader>a <Esc>:call IPhpInsertUse()<CR>
nnoremap <silent> <buffer> <localleader>a :call PhpInsertUse()<CR>
inoremap <silent> <buffer> <localleader>q <Esc>:call IPhpExpandClass()<CR>
nnoremap <silent> <buffer> <localleader>q :call PhpExpandClass()<CR>
inoremap <silent> <buffer> <localleader>.s <Esc>:call PhpSortUse()<CR>
nnoremap <silent> <buffer> <localleader>.s :call PhpSortUse()<CR>

" laravel
" nnoremap <silent> <buffer> <localleader>la :call system("tmux neww 'deh-laravel artisan; exec zsh'")<CR>
nnoremap <silent> <buffer> <localleader>la :call system("tmux neww 'deh-laravel artisan; zsh'")<CR>
nnoremap <silent> <buffer> <localleader>ldbc :terminal deh-laravel dbcreate<CR>
nnoremap <silent> <buffer> <localleader>ldbd :terminal deh-laravel dbdrop<CR>
nnoremap <silent> <buffer> <localleader>ldbos :call system("tmux splitw deh-laravel dbopen")<CR>
nnoremap <silent> <buffer> <localleader>ldbov :call system("tmux splitw -h deh-laravel dbopen")<CR>
nnoremap <silent> <buffer> <localleader>ldbow :call system("tmux neww deh-laravel dbopen")<CR>
nnoremap <silent> <buffer> <localleader>ldbot :call system("urxvt -name urxvtreplfloat -c ". getcwd() . " -e tmux new deh-laravel dbopen &")<CR>
nnoremap <silent> <buffer> <localleader>ldbs :terminal deh-laravel dbschema<CR>
nnoremap <silent> <buffer> <localleader>mtp :call system("tmux splitw deh-ctags-php-project")<CR>
nnoremap <silent> <buffer> <localleader>mtv :call system("tmux splitw deh-ctags-php-vendor")<CR>
