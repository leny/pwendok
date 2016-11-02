" leny/pwendok - vimrc file
" started at 02/11/2016

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" ----- Leader configuration
let mapleader="," " Switch leader char from backslash to comma

" ----- Editor config
set backspace=indent,eol,start " Allow backspacing everything in insert mode
set nobackup " Do not keep a backup file
set noswapfile " Same as above
set history=250 " Command history size
set showcmd " Display incomplete commands
set incsearch " Incremental search
set hlsearch " Highlight search result
set hidden " Hide buffers instead of closing
set number " Show line numbers
set smartindent " Use smartindenting
set autoindent " Copy indent from current line when starting new line
set tabstop=4 " Tabs are 4 spaces
set softtabstop=4 " Soft tabs are 4 spaces
set shiftwidth=4 " Indenting matches tabs
set expandtab " Expand tabs into spaces
set laststatus=2 " Use two lines for status
set foldmethod=indent " Use indent code folding
set encoding=utf-8 " Use UTF-8 encoding by default
set ignorecase " Ignore case on searching…
set smartcase " …unless the search has capitals in it
set modelines=0 " Disable modelines (in-file vim configuration overrides)
set showmatch " Show matching parenthesis
set nrformats=hex,alpha " Increment hex and alpha with numeric command
set wildmenu " Display autocomplete options
set nowrap " Don't wrap long lines
set linebreak " Wrap lines at convenient points
syntax on " Enable syntax highlighting
set autoread " Reload files changed outside vim
set fileformat=unix " Use unix line endings
set fileformats=unix,dos " Try unix line endings prior to dos
:au FocusLost * :wa "Save on focus lost
set ttyfast " Improve terminal redraw speed
set foldlevel=250 " Unfold all at opening

" ----- Color theme
colorscheme tomorrow-night-eighties

" ----- MacVim Configuration
set guifont=Fira\ Mono:h12

" ----- Splits Configuration
set splitbelow
set splitright

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" ----- Invisibles chars configuration
nmap <leader>l :set list!<CR> " Toggle invisible chars
set listchars=tab:••,eol:¬ " Customize chars used for invisibles

" ----- Toggle wrap
nmap <leader>w :set wrap!<CR> " Togglewrap

" ----- Scrolling
set scrolloff=8 " Lines to keep above and below the cursor 
set sidescrolloff=15
set sidescroll=1

" ----- Add save shortcuts
nmap <C-O> :w<CR> " nano-like save shortcut

" ----- Plugins configuration
filetype off
set rtp+=~/.vim/bundle/Vundle.vim " setup vundle
call vundle#begin() " start vundle plugins list
Plugin 'VundleVim/Vundle.vim' " Vundle needs to manage itself
" --- Utils plugins
Plugin 'scrooloose/nerdtree'
Plugin 'itchyny/lightline.vim'
Plugin 'easymotion/vim-easymotion'
Plugin 'tpope/vim-surround'
Plugin 'mattn/emmet-vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'airblade/vim-gitgutter'
Plugin 'raimondi/delimitmate'
" --- Syntax plugins
Plugin 'sheerun/vim-polyglot'
Plugin 'kchmck/vim-coffee-script'
Plugin 'pangloss/vim-javascript'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'jsx/jsx.vim'

call vundle#end() " end vundle plugins list
filetype plugin on

" ----- NERDTree configuration
let NERDTreeShowHidden = 1
autocmd vimenter * NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
map <leader>kb :NERDTreeToggle<CR>
map <leader>kf :NERDTreeFind<CR>

" ----- Lightline configuration
" TODO: https://github.com/itchyny/lightline.vim#configuration-tutorial

" ----- EasyMotion configuration
map <leader>e <plug>(easymotion-bd-w)
nmap <leader>e <plug>(easymotion-overwin-w)

" ----- Emmet configuration
let g:user_emmet_leader_key='<c-e>'

" ----- ctrlp configuration
let g:ctrlp_map = '<c-p>'

