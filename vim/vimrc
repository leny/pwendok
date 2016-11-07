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

" ----- Remap ; to : in normal mode (less misscases)
nnoremap ; :

"This unsets the "last search pattern" register by hitting return
nnoremap <CR> :noh<CR><CR>

" ----- Quicker escape mode
inoremap jj <ESC>

" ----- Remaps goto match
nnoremap <tab> %
vnoremap <tab> %

" ----- Disable arrows in normal mode
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>

nnoremap j gj
nnoremap k gk

" ----- Splits Configuration
set splitbelow
set splitright

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" ----- Invisibles chars configuration
nmap <leader>l :set list!<CR> " Toggle invisible chars
set listchars=tab:··,eol:¬ " Customize chars used for invisibles
set list

" ----- Toggle wrap
nmap <leader>w :set wrap!<CR> " Togglewrap

" ----- Scrolling
set scrolloff=8 " Lines to keep above and below the cursor
set sidescrolloff=15
set sidescroll=1

" ----- Add save shortcuts
nmap <C-O> :w<CR> " nano-like save shortcut
nmap <leader>w :w!<cr> " save with leader keystroke

" ----- Reloads .vimrc
nmap <Leader>s :source ~/.vimrc

" ----- Space to toggle folds
nnoremap <Space> za
vnoremap <Space> za

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
Plugin 'vim-scripts/gitignore'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'Shougo/neocomplete.vim'
" --- Syntax plugins
Plugin 'sheerun/vim-polyglot'
Plugin 'kchmck/vim-coffee-script'
Plugin 'pangloss/vim-javascript'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'jsx/jsx.vim'
Plugin 'vim-scripts/smarty-syntax'
Plugin 'wavded/vim-stylus'

call vundle#end() " end vundle plugins list
filetype plugin on

" ----- NERDTree configuration
let NERDTreeShowHidden = 1
map <leader>kb :NERDTreeToggle<CR>
map <leader>kf :NERDTreeFind<CR>

" ----- Lightline configuration
" TODO: https://github.com/itchyny/lightline.vim#configuration-tutorial

" ----- EasyMotion configuration
map <leader>e <plug>(easymotion-bd-w)
nmap <leader>e <plug>(easymotion-overwin-w)

" ----- Emmet configuration
let g:user_emmet_leader_key = '<c-y>'
let g:user_emmet_prev_key = '<c-j>'
let g:user_emmet_next_key = '<c-k>'
imap <expr> <tab> emmet#expandAbbrIntelligent("\<tab>")
autocmd FileType html,jade,css,sass,scss,stylus EmmetInstall
autocmd BufNewFile,BufReadPost *.styl set filetype=stylus
autocmd BufNewFile,BufReadPost *.css set filetype=css
autocmd BufRead,BufNewFile *.styl set filetype=css

" ----- ctrlp configuration
let g:ctrlp_map = '<c-p>'
map <c-p> :CtrlP<cr>
map <c-b> :CtrlPBufTag<cr>
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

" ----- whitespace cleaning
autocmd BufWritePre * :%s/\s\+$//e

" ----- neocomplete configuration
" (taken from deblan, need to refine)

function! s:my_cr_function()
	return neocomplete#close_popup() . "\<CR>"
	"return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
	"inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
	""	\ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
endfunction

if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif

if !exists('g:neocomplete#force_omni_input_patterns')
  let g:neocomplete#force_omni_input_patterns = {}
endif

let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#force_omni_input_patterns.php = '\h\w*\|[^. \t]->\%(\h\w*\)\?\|\h\w*::\%(\h\w*\)\?'
"let g:neocomplete#force_omni_input_patterns.php = '\h\w*\|[^- \t]->\w*'
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
\ }
let g:neocomplete#disable_auto_complete = 1
let g:neocomplete#keyword_patterns['default'] = '\h\w*'
inoremap <expr><C-g> neocomplete#undo_completion()
inoremap <expr><C-l> neocomplete#complete_common_string()
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>

inoremap <expr><TAB>
	\ pumvisible() ? "\<C-n>" :
	\ neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" :
	\ "\<TAB>"

inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
