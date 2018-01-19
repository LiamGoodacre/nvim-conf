set termguicolors

" # Plugins
call plug#begin()

" ## General
Plug 'junegunn/fzf'
Plug 'godlygeek/tabular'
Plug 'mhartington/oceanic-next'

" ## Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" ## Programming
Plug 'Shougo/deoplete.nvim'
Plug 'Shougo/vimproc.vim', { 'do' : 'make' }
Plug 'w0rp/ale'

Plug 'eagletmt/neco-ghc'
Plug 'neovimhaskell/haskell-vim'
Plug 'raichoo/purescript-vim'
Plug 'idris-hackers/idris-vim'

call plug#end()


" # General

set autoindent
set history=1000
set incsearch
set mouse=a
set nocompatible
set nowrap
set number
set relativenumber
set showmode
set smartcase
set softtabstop=2
set sw=2
set ts=2
set tw=0 " 79
set completeopt=menuone,menu,longest
set wildignore+=.git,.stack-work,*-doc-http.html,bower_components,node_modules
set wildmode=longest,list,full
set cmdheight=1
set spell spelllang=en_gb

" ## Breaking habits :-)

noremap  <Up>    <NOP>
vnoremap <Up>    <NOP>
noremap  <Down>  <NOP>
vnoremap <Down>  <NOP>
noremap  <Left>  <NOP>
vnoremap <Left>  <NOP>
noremap  <Right> <NOP>
vnoremap <Right> <NOP>

noremap  <Up>    ""
noremap! <Up>    <Nop>
noremap  <Down>  ""
noremap! <Down>  <Nop>
noremap  <Left>  ""
noremap! <Left>  <Nop>
noremap  <Right> ""
noremap! <Right> <Nop>

" ## Swap files and backups
set directory=$HOME/.vim/swapfiles//
set nobackup
set nowritebackup

" ## Grep updates
set grepprg=ag\ --nogroup\ --nocolor
map <Leader>s :grep<Space>

" ## Whitespace
map <Leader>c H:%s/\s*$//g<CR>:noh<CR><C-o>zt<C-o>
set listchars=nbsp:☠,tab:▸␣,tab:>-,trail:~,extends:>,precedes:<
set list

" # Programming
map <Leader>p :FZF<CR>

" Fix problems with crontab backups.
autocmd filetype crontab setlocal nobackup nowritebackup

" ## Grep browsing
nmap <silent> <C-N> :cn<CR>zv
nmap <silent> <C-P> :cp<CR>zv

" ## Haskell
let $PATH=$PATH . ':' . expand('~/.local/bin')

" Align import statements (tabulate AROUND the module name)
vmap <silent> <Leader>a :Tabularize/^[^A-Z]*\zs[A-Z][a-zA-Z0-9\\.]*<CR>


" # Syntax
syntax enable
let g:oceanic_next_terminal_bold=1
let g:oceanic_next_terminal_italic=1
colorscheme OceanicNext


" ## Pane control

nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k

set expandtab
