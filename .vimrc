" *** VIM CONFIG FILE ***

" SYNTAX HIGHLIGHTING
syntax on
" COLOR SCHEMES
set background=dark
" allow crontab editing on macOS
autocmd filetype crontab setlocal nobackup nowritebackup
" UTF8 SUPPORT
set encoding=utf-8
" docstrings for folded code %#%
let g:SimpylFold_docstring_preview=1
" LINE NUMBERING
set number
" Enhance command-line completion
set wildmenu
" Highlight current line
set cursorline
hi CursorLine term=bold cterm=bold guibg=Grey40
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

nnoremap <leader>d "_d

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
