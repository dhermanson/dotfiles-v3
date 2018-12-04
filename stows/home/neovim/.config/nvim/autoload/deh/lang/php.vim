if exists('g:deh#lang#php_loaded')
  finish
endif
let g:deh#lang#php_loaded = 1

let g:deh#lang#php_repl_session_prefix = "php-repl-"
let g:deh#lang#php_repl_session_name = ''
let g:deh#lang#php_repl_session_exists = 0
let g:deh#lang#php_repl_command = 'php artisan tinker'

" TODO: delete any outstanding repls when vim closed
function! g:deh#lang#php#setup_buffer()

  " tmux interaction
  nnoremap <buffer> <silent> <M-s> :call SendLineToTmuxPane(line('.'), g:deh#lang#php_repl_session_name)<CR>
  inoremap <buffer> <silent> <M-s> <C-o>:call SendLineToTmuxPane(line('.'), g:deh#lang#php_repl_session_name)<CR>
  vnoremap <buffer> <silent> <M-s> :\<C-u>call SendLinesToTmuxPane(line("'<"), line("'>"), g:deh#lang#php_repl_session_name)<CR>
  nnoremap <buffer> <silent> <M-r><M-k> :call KillTmuxPane(g:deh#lang#php_repl_session_name)<CR>
  nnoremap <buffer> <silent> <M-r><M-o> :call deh#lang#php#create_repl()<CR>
endfunction

function! g:deh#lang#php#create_repl()
  call deh#lang#php#kill_repl()
  let g:deh#lang#php_repl_session_name = CreateTmuxSessionName(g:deh#lang#php_repl_session_prefix)
  call CreateNewTmuxPane(g:deh#lang#php_repl_command, g:deh#lang#php_repl_session_name)
  let g:deh#lang#php_repl_session_exists = 1
endfunction

function! g:deh#lang#php#kill_repl()
  call KillTmuxPane(g:deh#lang#php_repl_session_name)
  let g:deh#lang#php_repl_session_name = ''
  let g:deh#lang#php_repl_session_exists = 0
endfunction


