
" ### SETTINGS FROM ###
" https://realpython.com/blog/python/vim-and-python-a-match-made-in-heaven/

set nocompatible              " required
filetype off                  " required
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" fold code
Plugin 'tmhedberg/SimpylFold'
" Python - indentation
Plugin 'vim-scripts/indentpython.vim'
" comment with shortcut
Plugin 'vim-scripts/tcomment'
" syntax checking
Plugin 'scrooloose/syntastic'
" color theme
Plugin 'altercation/vim-colors-solarized'
" file browsing
Plugin 'scrooloose/nerdtree'
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
" PYTHON INDENTATION
au BufNewFile,BufRead *.py set tabstop=4 
      \softtabstop=4 
      \shiftwidth=4  
      \textwidth=79  
      \expandtab  
      \autoindent  
      \fileformat=unix
" SYNTASTIC - PYTHON SYNTAX CHECKING
let g:syntastic_always_populate_loc_list = 0                                                                        
let g:syntastic_auto_loc_list = 1                                                                                   
let g:syntastic_check_on_open = 1                                                                                   
let g:syntastic_check_on_wq = 0                                                                                     
let g:syntastic_auto_jump = 1                                                                                       
let g:syntastic_loc_list_height = 3                                                                                 
let g:syntastic_python_checkers=['flake8']                                                                          
let g:syntastic_python_flake8_args='--ignore=E501,E225'

" FLAGGING UNNECESSARY WHITESPACE
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/
" SYNTAX CHECKING/HIGHLIGHTING
let python_highlight_all=1
syntax on
" COLOR SCHEMES
set background=dark
colorscheme solarized
" FILE BROWSING
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" MARKDOWN PREVIEW
" https://github.com/iamcco/markdown-preview.vim
let g:mkdp_path_to_chrome = "open -a Safari"
let g:mkdp_auto_start = 1
let g:mkdp_auto_open = 1
let g:mkdp_auto_close = 1
let g:mkdp_refresh_slow = 0
let g:mkdp_command_for_global = 0

" LATEX COMPILE
let g:vimtex_latexmk_callback = 0
autocmd BufWrite *.tex  :VimtexCompile
" allow crontab editing on macOS
autocmd filetype crontab setlocal nobackup nowritebackup
" UTF8 SUPPORT
set encoding=utf-8
" AUTO-COMPLETE
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>
" Enable folding
set foldmethod=indent
set foldlevel=99
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
" Enable split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" Enable folding with the spacebar
nnoremap <space> za
" LaTex - compile with F5
map <F5> <localleader>ll
" Enable changing the colormap using F6
call togglebg#map("<F6>")
" syntax/style checking toggle
map <buffer> <F7> :SyntasticToggleMode<CR>
" Markdown
nmap <silent> <F8> <Plug>MarkdownPreview
imap <silent> <F8> <Plug>MarkdownPreview
nmap <silent> <F9> <Plug>StopMarkdownPreview
imap <silent> <F9> <Plug>StopMarkdownPreview


