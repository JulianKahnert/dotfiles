
set nocompatible              " required
filetype off                  " required
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" comment with shortcut
Plugin 'vim-scripts/tcomment'
" color theme
Plugin 'altercation/vim-colors-solarized'
" bracket auto closing
Plugin 'itmammoth/doorboy.vim'
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
highlight BadWhitespace ctermbg=red guibg=red

" SYNTAX HIGHLIGHTING
syntax on
" COLOR SCHEMES
set background=dark
colorscheme solarized
" FILE BROWSING
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" allow crontab editing on macOS
autocmd filetype crontab setlocal nobackup nowritebackup
" UTF8 SUPPORT
set encoding=utf-8
" docstrings for folded code %#%
let g:SimpylFold_docstring_preview=1
" LINE NUMBERING
set number
" SYSTEM CLIPBOARD
set clipboard=unnamed
" Enhance command-line completion
set wildmenu
" Highlight current line
set cursorline
" Set to auto read when file is changed from the outside
set autoread
" Ignore case when searching
set ignorecase
" Highlight search results
set hlsearch
" Use Unix as the standard file type
set ffs=unix,dos,mac
" Use spaces instead of tabs
set expandtab
" Be smart when using tabs ;)
set smarttab
" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4
" Linebreak on 500 characters
set lbr
set tw=500
set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines
" Enable folding
set foldmethod=indent
set foldlevel=99


" KEY MAPPING

" Remove default arrow key mappings
no <up> <Nop>
" ino <down> <Nop>
" ino <left> <Nop>
" ino <right> <Nop>
no <up> <Nop>
no <down> <Nop>
no <left> <Nop>
no <right> <Nop>
vno <up> <Nop>
vno <down> <Nop>
vno <left> <Nop>
vno <right> <Nop>
" Map proper tabbing commands
map <C-n> :NERDTreeToggle<CR>
nmap <C-right> :tabnext<CR>
nmap <C-left> :tabprevious<CR>
map <C-right> :tabnext<CR>
map <C-left> :tabprevious<CR>
imap <C-right> <ESC>:tabprevious<CR>
imap <C-left> <ESC>:tabnext<CR>
