" *** VIM CONFIG FILE ***

" ============================================================================
" VIM-PLUG PLUGIN MANAGER
" ============================================================================
" Auto-install vim-plug if not present
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugin installation
call plug#begin('~/.vim/plugged')

" Git integration - show changes in sign column
Plug 'airblade/vim-gitgutter'

" Python code folding with docstring preview
Plug 'tmhedberg/SimpylFold'

" Nightfly colorscheme
Plug 'bluz71/vim-nightfly-colors', { 'as': 'nightfly' }

call plug#end()

" ============================================================================
" PLUGIN SETTINGS
" ============================================================================

" GitGutter settings
set updatetime=100                      " Update git signs faster (default 4000ms)
let g:gitgutter_sign_added = '+'       " Symbol for added lines
let g:gitgutter_sign_modified = '~'    " Symbol for modified lines
let g:gitgutter_sign_removed = '-'     " Symbol for removed lines
let g:gitgutter_max_signs = 500        " Max number of signs to show
highlight GitGutterAdd    guifg=#009900 ctermfg=2
highlight GitGutterChange guifg=#bbbb00 ctermfg=3
highlight GitGutterDelete guifg=#ff2222 ctermfg=1

" SimpylFold settings
let g:SimpylFold_docstring_preview=1   " Show docstrings for folded code

" ============================================================================
" BASIC SETTINGS
" ============================================================================

" SYNTAX HIGHLIGHTING
syntax on

" COLOR SCHEMES
set background=dark
set termguicolors
colorscheme nightfly

" allow crontab editing on macOS
autocmd filetype crontab setlocal nobackup nowritebackup

" UTF8 SUPPORT
set encoding=utf-8

" LINE NUMBERING
set number

" Show sign column always (for git indicators)
set signcolumn=yes

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

" Be smart when using tabs
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" Linebreak on 500 characters
set lbr
set tw=500

" Auto indent
set ai

" Smart indent
set si

" Wrap lines
set wrap

" Enable folding
set foldmethod=indent
set foldlevel=99

" ============================================================================
" KEY MAPPINGS
" ============================================================================

" Delete to black hole register (don't copy to clipboard)
nnoremap <leader>d "_d

" GitGutter navigation - jump between changed hunks
nmap ]h <Plug>(GitGutterNextHunk)
nmap [h <Plug>(GitGutterPrevHunk)

" GitGutter actions
nmap <Leader>hp <Plug>(GitGutterPreviewHunk)
nmap <Leader>hs <Plug>(GitGutterStageHunk)
nmap <Leader>hu <Plug>(GitGutterUndoHunk)

" Remove arrow key mappings to force using hjkl
noremap <up> <Nop>
noremap <down> <Nop>
noremap <left> <Nop>
noremap <right> <Nop>
vnoremap <up> <Nop>
vnoremap <down> <Nop>
vnoremap <left> <Nop>
vnoremap <right> <Nop>
