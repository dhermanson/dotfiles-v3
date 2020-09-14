" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.local/share/nvim/plugged')

" Colors / Interface
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'altercation/vim-colors-solarized'
Plug 'vim-airline/vim-airline-themes'
Plug 'challenger-deep-theme/vim'
Plug 'jnurmine/Zenburn'
Plug 'arcticicestudio/nord-vim'
Plug 'chriskempson/base16-vim'
Plug 'sonph/onehalf', {'rtp': 'vim/'}
Plug 'cormacrelf/vim-colors-github'
Plug 'ayu-theme/ayu-vim'
Plug 'rakr/vim-one'
Plug 'rakr/vim-two-firewatch'
Plug 'NLKNguyen/papercolor-theme'
" Plug 'icymind/NeoSolarized'

" Essentials
Plug 'scrooloose/nerdtree'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
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
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-tbone'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-unimpaired'
Plug 'embear/vim-localvimrc'
" Plug 'tpope/vim-vinegar'
Plug 'airblade/vim-gitgutter'
Plug 'schickling/vim-bufonly'
Plug 'qpkorr/vim-bufkill'

" Random
Plug 'gcmt/taboo.vim'

" Plug 'neoclide/coc.nvim', {'tag': '*', 'do': './install.sh'}

Plug 'roxma/nvim-yarp' " a dependency of 'ncm2'
Plug 'ncm2/ncm2' " v2 of the nvim-completion-manager
Plug 'ncm2/ncm2-ultisnips'
Plug 'ncm2/ncm2-tagprefix'
" LanguageServer client for NeoVim.
Plug 'autozimu/LanguageClient-neovim', {
  \ 'branch': 'next',
  \ 'do': 'bash install.sh',
  \ }

Plug 'kana/vim-textobj-user'

" Languages
" Plug 'sheerun/vim-polyglot'
" Plug 'vim-pandoc/vim-pandoc'
" Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'pangloss/vim-javascript' "javascript
Plug 'udalov/kotlin-vim' "kotlin
Plug 'HerringtonDarkholme/yats.vim' "typescript
" Plug 'lervag/vimtex' "latex
Plug 'aklt/plantuml-syntax' "plantuml
Plug 'chr4/nginx.vim' " nginx

" ruby
Plug 'nelstrom/vim-textobj-rubyblock'

" Plug 'phpactor/phpactor' ,  {'do': 'composer install', 'for': 'php'}
Plug 'arnaud-lb/vim-php-namespace', { 'for': 'php' }
Plug 'jwalton512/vim-blade'

" api blueprint
Plug 'kylef/apiblueprint.vim', { 'for': 'apiblueprint' }

" html-ish
Plug 'mattn/emmet-vim'

" go
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" vue
Plug 'posva/vim-vue'

" yaml
Plug 'stephpy/vim-yaml'

" groovy
Plug 'vim-scripts/groovyindent-unix'
Plug 'vim-scripts/groovy.vim'

" avro
Plug 'gurpreetatwal/vim-avro'

" graphql
Plug 'jparise/vim-graphql'

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
if has('nvim')
  autocmd BufEnter * call ncm2#enable_for_buffer()
endif

" ale
let g:ale_linters = {
      \   'php': ['phpstan']
  \}
let g:ale_php_phpstan_level = 4
" " let g:ale_php_phpstan_executable = "./vendor/bin/phpstan"
" let g:ale_php_phpstan_executable = $HOME."/tools/phpstan"
let g:ale_lint_on_enter=1
" let g:ale_echo_cursor=0
let g:ale_virtualtext_cursor=0

" delimitmate
let g:delimitMate_expand_cr=1
let g:delimitMate_expand_space=1
let g:delimitMate_jump_expansion=1

" tagbar
let g:tagbar_autopreview = 0
let g:tagbar_expand = 1
let g:tagbar_autoclose = 0

" nerdtree
let g:NERDTreeQuitOnOpen=0
let g:NERDTreeShowHidden=1
let g:NERDTreeIgnore = ['\.png$']

" gitgutter
let g:gitgutter_enabled=1

" vim-pandoc
" let g:pandoc#modules#disabled = ["chdir", "folding"] " don't automatically change directory

" language client
" let g:LanguageClient_serverCommands = {
"   \ 'javascript': ['javascript-typescript-stdio'],
"   \ 'typescript': ['javascript-typescript-stdio'],
"   \ 'java': ['jdtls']
"   \ }

" repl
    " \   "php": g:deh#repl#TmuxRepl#new("php-repl", "psysh"),
    " \   "python": g:deh#repl#TmuxRepl#new("python-repl", "bash -c '. ./venv/bin/activate; python3'"),
    " TODO: move away from hard-coding repls per language
    "       and towards a system where any language can select an arbitrary
    "       tmux pane as a general repl. also add support for different types
    "       of repls. use something like emacs's hydra-mode to have each repl
    "       implementation display what it can do, and provide its own
    "       keybindings. also capture output of the resulting command and
    "       insert it into a vim register. that would be handy for things like
    "       sql repls where you want the results of queries
let g:deh#repl#repls = {
    \   "ruby": g:deh#repl#TmuxRepl#new("ruby-repl", "pry"),
    \   "sql": g:deh#repl#TmuxRepl#new("sql-repl", "zsh"),
    \   "php": g:deh#repl#TmuxRepl#new("php-repl", "php artisan tinker"),
    \   "python": g:deh#repl#TmuxRepl#new("python-repl", "python3"),
    \   "javascript": g:deh#repl#TmuxRepl#new("js-repl", "node"),
    \   "zsh": g:deh#repl#TmuxRepl#new("zsh-repl", "zsh"),
    \   "sh": g:deh#repl#TmuxRepl#new("sh-repl", "zsh"),
    \   "bash": g:deh#repl#TmuxRepl#new("bash-repl", "zsh"),
    \   "posix": g:deh#repl#TmuxRepl#new("posix-repl", "zsh"),
    \   "markdown": g:deh#repl#TmuxRepl#new("markdown-repl", "zsh"),
    \   "kotlin": g:deh#repl#TmuxRepl#new("kotlin-repl", "kotlinc"),
    \ }

" fzf
let g:fzf_prefer_tmux = 1


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Basic Settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible
syntax on
filetype plugin indent on
" filetype detect

" runtime macros/matchit.vim
" packadd! matchit


set termguicolors
" set t_Co=256
set background=light
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
" set nocursorcolumn
set noswapfile
set nohlsearch
set cursorline
set nosplitbelow
set splitright
set ignorecase
set nolazyredraw
set hidden
set foldmethod=marker

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


" let g:loaded_matchit = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colors / Interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" " let g:gruvbox_italic=1
" " let g:gruvbox_invert_signs=0
" " let g:gruvbox_contrast_dark='medium'
" let g:gruvbox_contrast_light='medium'
" let g:gruvbox_invert_selection=0
" " let g:gruvbox_italic=1
"  colorscheme gruvbox
" " highlight SignColumn ctermbg=236
" " highlight VertSplit ctermbg=236
" " highlight Comment cterm=italic
" let g:airline_theme='gruvbox'
" let g:airline_powerline_fonts = 0

" colorscheme zenburn
" let g:airline_theme='zenburn'
" let g:airline#extensions#ale#enabled = 1
" let g:airline_left_sep=''		
" let g:airline_right_sep=''		
" let g:airline_symbols = {}		
" let g:airline_theme='zenburn'
" let g:airline_powerline_fonts = 0

" colorscheme nord

" let g:solarized_termcolors=256
" colorscheme solarized
" let g:airline_theme='solarized'
" let g:airline#extensions#ale#enabled = 1
" let g:airline_left_sep=''		
" let g:airline_right_sep=''		
" let g:airline_symbols = {}		
" let g:airline_theme='solarized'
" let g:airline_powerline_fonts = 0

" colorscheme base16-github
" colorscheme base16-tomorrow
" colorscheme base16-solarized-dark

" colorscheme onehalflight
" let g:airline_theme='onehalflight'

" colorscheme one
" let g:airline_theme='one'

colorscheme PaperColor
let g:airline_theme='papercolor'

" let g:two_firewatch_italics=1
" colorscheme two-firewatch
" let g:airline_theme='twofirewatch'

" colorscheme github
" let g:airline_theme='github'

" let ayucolor="light"
" colorscheme ayu

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Keyboard Mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" leader keys
let mapleader=" "
let maplocalleader = ","

if has('nvim')
  tnoremap <silent> <M-Backspace> <C-\><C-n>
endif

inoremap jk <Esc>

" map empty project mapping to noop...cuz sometimes i forget what i'm doing
nnoremap <Leader>p <Nop>

" updating vimrc file
nnoremap <Leader>.ev :e $MYVIMRC<CR>
nnoremap <Leader>.sv :source $MYVIMRC<CR>

" save
inoremap <M-w> <C-o>:w<CR>
nnoremap <M-w> :w<CR>

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
" nnoremap <Leader>q :bdelete<CR>
nnoremap <silent> <M-q> :BD<CR>
" nnoremap <Leader>q :bdelete<CR>
" nnoremap <M-q> :bdelete<CR>
" nnoremap <M-Q> :call ConfirmBDeleteBang()<CR>
" close buffer
nnoremap <silent> <M-c> <C-w>c

" explore folder of current buffer
nnoremap - :e %:h<CR>

" ack
nnoremap <Leader>a :Ack! 

" easymotion
map <silent> / <Plug>(easymotion-sn)
omap <silent> / <Plug>(easymotion-tn)
map <Leader>; <Plug>(easymotion-bd-f)

" fugitive
" nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gs :call system("magit")<CR>
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
let g:UltiSnipsSnippetsDir = $HOME . "/.config/nvim/ultisnips"
let g:UltiSnipsSnippetDirectories = [$HOME . "/.config/nvim/ultisnips", "UltiSnips"]
let g:UltiSnipsExpandTrigger="<tab>"
"let g:UltiSnipsListSnippets="<c-l>"
let g:UltiSnipsJumpForwardTrigger="<m-n>"
let g:UltiSnipsJumpBackwardTrigger="<m-p>"
nnoremap <Leader>.es :UltiSnipsEdit<CR>

" searching
nnoremap <Leader>f :Files<CR>
inoremap <M-f> <Esc>:Files<CR>
nnoremap <M-f> :Files<CR>

" TODO: put this somewhere else...i might not even like it to begin with
  " \ {'source': 'find '.(empty(<f-args>) ? '.' : <f-args>).' -type d',
command! -nargs=* -complete=dir SearchForDirUnderDir call fzf#run(fzf#wrap(
  \ {'source': "git ls-files --cached --others --exclude-standard | xargs -n 1 dirname | uniq ",
  \  'sink': 'e'}))

nnoremap <M-d> :SearchForDirUnderDir .<CR>
nnoremap <Leader>b :Buffers<CR>
nnoremap <M-b> :Buffers<CR>
inoremap <M-b> <Esc>:Buffers<CR>
nnoremap <Leader>k :Tags<CR>
" nnoremap <Leader>l :CtrlPBufTag<CR>
nnoremap <Leader>l :BTags<CR>

" vim-bufonly
nnoremap <M-O> :BufOnly<CR>

" nerdtree
nnoremap <M-;> :NERDTreeFocus<CR>
nnoremap <M-'> :NERDTreeToggle<CR>
nnoremap <M-:> :NERDTreeFind<CR>

nnoremap <silent> <M-s> :call deh#repl#send_current_line()<CR>
inoremap <silent> <M-s> <C-o>:call deh#repl#send_current_line()<CR>
vnoremap <silent> <M-s> :<C-u>call deh#repl#send_selected_lines()<CR>
" DON'T MAP THE SESSION STOPS OR RESTARTS RIGHT NOW
nnoremap <silent> <leader>rk :call deh#repl#stop()<CR>
" nnoremap <silent> <leader>rks :call deh#repl#stop_session()<CR>
" nnoremap <silent> <leader>rr :call deh#repl#restart()<CR>
nnoremap <silent> <leader>rp :call deh#repl#select_pane()<CR>
nnoremap <silent> <leader>rs :call deh#repl#select_session()<CR>
nnoremap <silent> <leader>ro :call deh#repl#start('other-window')<CR>
nnoremap <silent> <leader>rj :call deh#repl#start('below')<CR>
nnoremap <silent> <leader>rl :call deh#repl#start('right')<CR>

" vim-easy-align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
vnoremap <silent> <M-a><M-a> :EasyAlign<CR>
vnoremap <M-a><M-r> :EasyAlign //<left>
vnoremap <silent> <M-a>\| :EasyAlign *\|<CR>
vnoremap <silent> <M-a><M-t> :EasyAlign *\|<CR>
vnoremap <silent> <M-a><M-d> :EasyAlign dr<CR>
vnoremap <silent> <M-a><M-j> :EasyAlign :<CR>

" languageclient
let g:LanguageClient_selectionUI="fzf"
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
" nnoremap <silent> <M-d><M-m> :call LanguageClient_contextMenu()<CR>
" nnoremap <silent> <M-d><M-h> :call LanguageClient#textDocument_hover()<CR>
" nnoremap <silent> <M-d><M-d> :call LanguageClient#textDocument_definition()<CR>
" nnoremap <silent> <M-d><M-t> :call LanguageClient#textDocument_typeDefinition()<CR>
" nnoremap <silent> <M-d><M-i> :call LanguageClient#textDocument_implementation()<CR>
" nnoremap <silent> <M-d><M-s> :call LanguageClient#textDocument_documentSymbol()<CR>
" nnoremap <silent> <M-d><M-r> :call LanguageClient#textDocument_references()<CR>
" nnoremap <silent> <M-d><M-a> :call LanguageClient#textDocument_codeAction()<CR>
" nnoremap <silent> <M-d><M-c> :call LanguageClient#textDocument_formatting()<CR>
" nnoremap <silent> <M-d><M-n> :call LanguageClient#textDocument_rename()<CR>
" nnoremap <silent> <M-d><M-f> :call LanguageClient#workspace_symbol()<CR>

nnoremap <silent> <M-[> :tabnext<CR>
nnoremap <silent> <M-]> :tabprevious<CR>
nnoremap <silent> <leader>nt :tabnew<CR>
nnoremap <silent> <M-t> :tabnew<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Filetypes
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" markdown
" autocmd FileType markdown setlocal commentstring=<!--\ %s\ -->

augroup deh_augroup
  autocmd!
  " xml
  autocmd FileType xml setlocal shiftwidth=4 tabstop=4 expandtab softtabstop=4

  " avro
  autocmd BufRead,BufNewFile *.avsc set filetype=json
  autocmd BufRead,BufNewFile *.avro set filetype=json

  " kotlin
  autocmd FileType kotlin setlocal shiftwidth=4 tabstop=4 expandtab softtabstop=4

  " cursor columns
  autocmd WinEnter,BufWinEnter * set cul
  autocmd WinLeave,BufWinLeave * set nocul
augroup END


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

" au! BufNewFile,BufReadPost *.{yaml,yml} set filetype=yaml
" autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
" au TextChangedI * call ncm2#auto_trigger()
