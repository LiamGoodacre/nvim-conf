" reset vim
set all&
mapc " nvo
xmapc
smapc
mapc! " ci
lmapc
tmapc
highlight clear

call plug#begin('~/.local/share/nvim/plugged')
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'easymotion/vim-easymotion'
Plug 'neovimhaskell/haskell-vim'
" Plug 'purescript-contrib/purescript-vim'
" Plug 'FrigoEU/psc-ide-vim'
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'leafgarland/typescript-vim'
" Plug 'Quramy/tsuquyomi'
call plug#end()

let g:typescript_indent_disable = 1

set directory=~/.local/share/nvim/swap/

set completeopt+=menuone,noinsert,noselect
set confirm
set cursorcolumn
set cursorline
set expandtab
set formatoptions+=n
set grepprg=ripgrep.rg\ --vimgrep
set hidden
set incsearch
set list
set listchars+=tab:\ \ ,trail:\ 
set noautoindent
set nowrap
set number
set relativenumber
set ruler
set shiftround
set shiftwidth=2
set shortmess+=I
set showcmd
set showmatch
set softtabstop=2
set spell spelllang=en_gb
set splitbelow
set splitright
set suffixes+=.git,.stack-work,-doc-http.html
set tabstop=2
set termguicolors
set ttyfast
set wildignore+=.git,.stack-work,*-doc-http.html,bower_components,node_modules
set wildmenu
set wildmode+=list,longest
set foldmethod=marker

set background=dark
colorscheme evening
highlight Conceal guifg=#ffffff guibg=#000000

nnoremap <C-Space> :Buffers<CR>
nnoremap <C-e> :GFiles<CR>
nnoremap <C-s> :Files %:p:h<CR>
nnoremap <C-g>b :BCommits<CR>
nnoremap <C-g>g :Commits<CR>
nnoremap <silent> <C-N> :cn<CR>zv
nnoremap <silent> <C-P> :cp<CR>zv

nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k

nmap <silent> <C-g>n :tabn<CR>
nmap <silent> <C-g>p :tabN<CR>
nmap <silent> <C-g><C-n> :tabm +1<CR>
nmap <silent> <C-g><C-p> :tabm -1<CR>

function! AlwaysUpdate()
  set updatetime=250
  au CursorHold,CursorHoldI <buffer> :update
endfunction

let g:haskell_indent_disable=1

