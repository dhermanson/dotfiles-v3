if exists('g:deh#lang#ruby_loaded')
  finish
endif
let g:deh#lang#ruby_loaded = 1

let g:deh#lang#ruby_repl_session_prefix = "ruby-repl-"
let g:deh#lang#ruby_repl_session_name = ''
let g:deh#lang#ruby_repl_session_exists = 0
let g:deh#lang#ruby_repl_command = 'pry'

" TODO: delete any outstanding repls when vim closed
function! g:deh#lang#ruby#setup_buffer()

  " TODO: make a ruby object here
  " let b:deh#repl#impl = new rubyobject()
  " then all of these mappings aren't lang specific
  " i can make my ruby object implement interfaces
  
  " tmux interaction
  nnoremap <buffer> <silent> <M-s> :call SendLineToTmuxPane(line('.'), g:deh#lang#ruby_repl_session_name)<CR>
  inoremap <buffer> <silent> <M-s> <C-o>:call SendLineToTmuxPane(line('.'), g:deh#lang#ruby_repl_session_name)<CR>
  vnoremap <buffer> <silent> <M-s> :\<C-u>call SendLinesToTmuxPane(line("'<"), line("'>"), g:deh#lang#ruby_repl_session_name)<CR>
  nnoremap <buffer> <silent> <M-r><M-k> :call KillTmuxPane(g:deh#lang#ruby_repl_session_name)<CR>
  nnoremap <buffer> <silent> <M-r><M-o> :call deh#lang#ruby#create_repl()<CR>
  nnoremap <buffer> <silent> <M-r><M-r> :call deh#lang#ruby#reset_repl()<CR>
endfunction

function! g:deh#lang#ruby#create_repl()
  call deh#lang#ruby#kill_repl()
  let g:deh#lang#ruby_repl_session_name = CreateTmuxSessionName(g:deh#lang#ruby_repl_session_prefix)
  call CreateNewTmuxPane(g:deh#lang#ruby_repl_command, g:deh#lang#ruby_repl_session_name)
  let g:deh#lang#ruby_repl_session_exists = 1
endfunction

function! g:deh#lang#ruby#reset_repl()

  call SendSymbolToTmuxPane(".reset", g:deh#lang#ruby_repl_session_name)
  call SendSymbolToTmuxPane(".clear", g:deh#lang#ruby_repl_session_name)
endfunction

function! g:deh#lang#ruby#kill_repl()
  call KillTmuxPane(g:deh#lang#ruby_repl_session_name)
  let g:deh#lang#ruby_repl_session_name = ''
  let g:deh#lang#ruby_repl_session_exists = 0
endfunction
