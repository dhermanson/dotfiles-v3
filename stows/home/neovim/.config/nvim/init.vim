" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.local/share/nvim/plugged')

" Colors / Interface
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'

" Essentials
Plug 'scrooloose/nerdtree'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'easymotion/vim-easymotion'
Plug 'majutsushi/tagbar'
Plug 'mileszs/ack.vim'
Plug 'w0rp/ale'
Plug 'Raimondi/delimitMate'
Plug 'SirVer/ultisnips'
Plug 'tommcdo/vim-fubitive'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-tbone'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-unimpaired'
" Plug 'tpope/vim-vinegar'
Plug 'airblade/vim-gitgutter'
Plug 'schickling/vim-bufonly'

Plug 'roxma/nvim-yarp' " a dependency of 'ncm2'
Plug 'ncm2/ncm2' " v2 of the nvim-completion-manager
" Plug 'ncm2/nvim-typescript', {'do': './install.sh'} " typescript completion source
" LanguageServer client for NeoVim.
Plug 'autozimu/LanguageClient-neovim', {
  \ 'branch': 'next',
  \ 'do': 'bash install.sh',
  \ }

" Languages
" Plug 'sheerun/vim-polyglot'
" Plug 'vim-pandoc/vim-pandoc'
" Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'udalov/kotlin-vim'
Plug 'HerringtonDarkholme/yats.vim'

" Plug 'phpactor/phpactor' ,  {'do': 'composer install', 'for': 'php'}
Plug 'arnaud-lb/vim-php-namespace', { 'for': 'php' }
Plug 'jwalton512/vim-blade'

" api blueprint
Plug 'kylef/apiblueprint.vim', { 'for': 'apiblueprint' }

" html-ish
Plug 'mattn/emmet-vim'

" Initialize plugin system
call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin Configuration
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" easymotion
let g:EasyMotion_do_mapping = 0 " Disable default mappings
let g:EasyMotion_smartcase = 1

" ack
let g:ackprg = 'rg --vimgrep --no-heading '


" ncm2
autocmd BufEnter * call ncm2#enable_for_buffer()


" ale
let g:ale_lint_on_enter=0

" delimitmate
let g:delimitMate_expand_cr=1
let g:delimitMate_expand_space=1
let g:delimitMate_jump_expansion=1

" ultisnips
let g:UltiSnipsSnippetsDir = $HOME . "/.config/nvim/ultisnips"

" tagbar
let g:tagbar_autopreview = 0
let g:tagbar_expand = 1
let g:tagbar_autoclose = 0

" nerdtree
let g:NERDTreeQuitOnOpen=0

" gitgutter
let g:gitgutter_enabled=1

" vim-pandoc
let g:pandoc#modules#disabled = ["chdir", "folding"] " don't automatically change directory

" language client
let g:LanguageClient_serverCommands = {
  \ 'javascript': ['javascript-typescript-stdio'],
  \ 'typescript': ['javascript-typescript-stdio']
  \ }


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Basic Settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible
syntax on
filetype plugin indent on
set termguicolors
set t_Co=256
set background=dark
set completeopt=noinsert,menuone,noselect " ncm2 needs these set this way
set timeout timeoutlen=1000 ttimeoutlen=100
set tabstop=2
set shiftwidth=2
set backspace=indent,eol,start
set expandtab
set number
set relativenumber
set noshowmode
set mouse=a
set complete=.,w,b,u
set autowriteall
set nocursorline
set nocursorcolumn
set noswapfile
set nohlsearch
set cursorline
set nosplitbelow
set splitright
set ignorecase
set nolazyredraw

" no bells
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=
set magic " Set magic on, for regex
set showmatch " show matching braces
set mat=2 " how many tenths of a second to blink
set encoding=utf8

set directory=~/.config/nvim/swap// " The double '//' ensures that there will be no name conflicts
set backupdir=~/.config/nvim/backup//
set undodir=~/.config/nvim/undo//

let g:netrw_liststyle=3

if !has('nvim')
  set ttymouse=xterm2
endif

augroup my_cursor_line " only show cursorline in active buffer
  autocmd!
  autocmd WinEnter,BufWinEnter * set cul
  autocmd WinLeave,BufWinLeave * set nocul
augroup END


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colors / Interface
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:gruvbox_italic=0
let g:gruvbox_invert_signs=1
let g:gruvbox_contrast_dark='medium'
let g:gruvbox_invert_selection=0
let g:gruvbox_italic=1
colorscheme gruvbox
highlight SignColumn ctermbg=236
highlight VertSplit ctermbg=236
highlight Comment cterm=italic
let g:airline_theme='gruvbox'
let g:airline#extensions#ale#enabled = 1
let g:airline_powerline_fonts = 0
let g:airline_left_sep=''		
let g:airline_right_sep=''		
let g:airline_symbols = {}		


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Keyboard Mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" leader keys
let mapleader=" "
let maplocalleader = ","

" map empty project mapping to noop...cuz sometimes i forget what i'm doing
nnoremap <Leader>p <Nop>

" updating vimrc file
nnoremap <Leader>.ev :e $MYVIMRC<CR>
nnoremap <Leader>.sv :source $MYVIMRC<CR>

" save
inoremap <M-w> <C-o>:w<CR>
nnoremap <M-w> :w<CR>

" escape on jk
inoremap jk <Esc>
onoremap jk <Esc>
cnoremap jk <C-c>

" leave only this window open
nnoremap <M-o> <C-w>o

" move to split if exists, else create new one and go
nnoremap <silent> <M-h> :call WinMove('h')<cr>
nnoremap <silent> <M-j> :call WinMove('j')<cr>
nnoremap <silent> <M-k> :call WinMove('k')<cr>
nnoremap <silent> <M-l> :call WinMove('l')<cr>

" move current split to left, down, up, right respectively
nnoremap <silent> <M-H> <C-w>H
nnoremap <silent> <M-J> <C-w>J
nnoremap <silent> <M-K> <C-w>K
nnoremap <silent> <M-L> <C-w>L

" lookup tag in insert mode
inoremap <M-t> <C-x><C-]>

" apply macros with Q
nnoremap Q @q
vnoremap Q :norm @q<cr>

" delete buffer
nnoremap <Leader>q :bdelete<CR>
nnoremap <M-q> :bdelete<CR>
nnoremap <M-Q> :call ConfirmBDeleteBang()<CR>
" close buffer
nnoremap <M-c> <C-w>c

" ack
nnoremap <Leader>a :Ack! 

" easymotion
map <silent> / <Plug>(easymotion-sn)
omap <silent> / <Plug>(easymotion-tn)
map <Leader>; <Plug>(easymotion-bd-f)

" fugitive
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gd :Gdiff<CR>
nnoremap <Leader>ge :Gedit<CR>
nnoremap <Leader>gl :Glog<CR>
nnoremap <Leader>gb :Gblame<CR>
nnoremap <Leader>gw :Gwrite<CR>
nnoremap <Leader>gc :Commits<CR>

" ale
nnoremap <silent> <M-g><M-p> :ALEPrevious<CR>
nnoremap <silent> <M-g><M-n> :ALENext<CR>

" ultisnips
let g:UltiSnipsExpandTrigger="<tab>"
"let g:UltiSnipsListSnippets="<c-l>"
let g:UltiSnipsJumpForwardTrigger="<m-n>"
let g:UltiSnipsJumpBackwardTrigger="<m-p>"
nnoremap <Leader>.es :UltiSnipsEdit<CR>

" searching
nnoremap <Leader>f :Files<CR>
inoremap <M-f> <Esc>:Files<CR>
nnoremap <M-f> :Files<CR>
nnoremap <Leader>b :Buffers<CR>
nnoremap <M-b> :Buffers<CR>
inoremap <M-b> <Esc>:Buffers<CR>
nnoremap <Leader>k :Tags<CR>
nnoremap <Leader>l :CtrlPBufTag<CR>

" vim-bufonly
nnoremap <M-O> :BufOnly<CR>

" nerdtree
nnoremap <M-;> :NERDTreeFocus<CR>
nnoremap <M-'> :NERDTreeToggle<CR>
nnoremap <M-:> :NERDTreeFind<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Functions
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" move to the window in the direction shown, or create a new window
function! WinMove(key)
    let t:curwin = winnr()
    exec "wincmd ".a:key
    if (t:curwin == winnr())
        if (match(a:key,'[jk]'))
            wincmd v
        else
            wincmd s
        endif
        exec "wincmd ".a:key
    endif
endfunction

function! ConfirmBDeleteBang()
  let l:choice = confirm("Really delete buffer?", "&Yes\n&No")
  if l:choice == 1
    execute "bdelete!"
  endif
endfunction

source $HOME/.config/nvim/tmux.vim

autocmd FileType ruby call deh#lang#ruby#setup_buffer()
autocmd FileType php call deh#lang#php#setup_buffer()
