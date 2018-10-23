" reset vim
set all&
mapc   " nvo
xmapc
smapc
mapc!  " ci
lmapc
tmapc
highlight clear

call plug#begin('~/.local/share/nvim/plugged')
Plug 'godlygeek/tabular'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'easymotion/vim-easymotion'
Plug 'neovimhaskell/haskell-vim'
"Plug 'purescript-contrib/purescript-vim'
call plug#end()

colorscheme desert
highlight TabLine gui=NONE guibg=grey10 guifg=grey40
highlight TabLineSel gui=NONE guibg=grey20
highlight TabLineFill gui=NONE guibg=grey10
highlight ColorColumn guibg=grey16
highlight VertSplit guifg=white guibg=grey20
highlight StatusLine guifg=grey10 guibg=white gui=bold
highlight StatusLineNC guifg=white guibg=grey10 gui=bold
highlight EndOfBuffer guibg=black
highlight CursorLineNr guibg=white guifg=black
highlight LineNr guibg=black guifg=white

let g:haskell_indent_disable=1

set autoread
set backspace=eol,indent,start
set backupdir=$HOME/.vim/backups
set bufhidden=hide
set colorcolumn=+1
set completeopt+=menuone,longest
set confirm
set copyindent
set cursorcolumn
set cursorline
set directory=$HOME/.vim/swapfiles
set display=lastline
set eadirection=both
set encoding=utf-8
set expandtab
set formatoptions+=n
set grepprg=rg\ --vimgrep
set hidden
set history=1000
set hlsearch
set incsearch
set laststatus=2
set list
set listchars+=tab:>\ ,trail:-,eol:ϟ
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

map <Leader>s :grep<Space>
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
