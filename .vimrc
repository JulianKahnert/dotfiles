
" SETTINGS FROM:
" https://realpython.com/blog/python/vim-and-python-a-match-made-in-heaven/

set nocompatible              " required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" #### Plugin Area ####
" fold code
Plugin 'tmhedberg/SimpylFold'
" Python: indentation
Plugin 'vim-scripts/indentpython.vim'
" comment with shortcut
Plugin 'vim-scripts/tcomment'
" syntax checking
Plugin 'scrooloose/syntastic'
" Python: syntax/style checking
Plugin 'nvie/vim-flake8'
" color theme
Plugin 'altercation/vim-colors-solarized'
" file browsing
Plugin 'scrooloose/nerdtree'
" file browsing tabs
Plugin 'jistr/vim-nerdtree-tabs'
" Markdown Prewview
Plugin 'iamcco/markdown-preview.vim'
" bracket auto closing
Plugin 'itmammoth/doorboy.vim'
" LaTex plugin
Plugin 'lervag/vimtex'
" code-completion engine
Bundle 'Valloric/YouCompleteMe'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
highlight BadWhitespace ctermbg=red guibg=red

" Enable folding
set foldmethod=indent
set foldlevel=99
" docstrings for folded code %#%
let g:SimpylFold_docstring_preview=1


" PYTHON INDENTATION
au BufNewFile,BufRead *.py set tabstop=4 
      \softtabstop=4 
      \shiftwidth=4  
      \textwidth=79  
      \expandtab  
      \autoindent  
      \fileformat=unix

" FLAGGING UNNECESSARY WHITESPACE
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" UTF8 SUPPORT
set encoding=utf-8

" AUTO-COMPLETE
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

" SYNTAX CHECKING/HIGHLIGHTING
let python_highlight_all=1
syntax on

" COLOR SCHEMES
set background=dark
colorscheme solarized
highlight LineNr ctermfg=green

" FILE BROWSING
" let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree
autocmd vimenter * NERDTree
autocmd VimEnter * wincmd p
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" LINE NUMBERING
set number

" SYSTEM CLIPBOARD
set clipboard=unnamed

" MARKDOWN PREVIEW
" https://github.com/iamcco/markdown-preview.vim
let g:mkdp_path_to_chrome = "open -a Safari"
let g:mkdp_auto_start = 1
let g:mkdp_auto_open = 1
let g:mkdp_auto_close = 1
let g:mkdp_refresh_slow = 0
let g:mkdp_command_for_global = 0

" #### FROM JAN ####
" Set to auto read when file is changed from the outside
set autoread
" Ignore case when searching
set ignorecase
" When searching try to be smart about cases
set smartcase
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
" Allow proper crontab-editing on macOS
au BufEnter /private/tmp/crontab.* setl backupcopy=yes
autocmd ColorScheme * highlight UnwanttedTab ctermbg=red guibg=darkred
autocmd ColorScheme * highlight TrailSpace guibg=red ctermbg=darkred


" KEY MAPPING

" Remove default arrow key mappings
no <up> <Nop>
ino <down> <Nop>
ino <left> <Nop>
ino <right> <Nop>
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
" Enable split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" Enable folding with the spacebar
nnoremap <space> za
" Flake8 - Python syntax/style checking
autocmd FileType python map <buffer> <F6> :call Flake8()<CR>
" Enable changing the colormap using F5
call togglebg#map("<F7>")
" Map Ctrl+l to clear highlighted searches
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>
" Markdown
nmap <silent> <F8> <Plug>MarkdownPreview
imap <silent> <F8> <Plug>MarkdownPreview
nmap <silent> <F9> <Plug>StopMarkdownPreview
imap <silent> <F9> <Plug>StopMarkdownPreview

