set nocompatible               " be iMproved

set foldmethod=indent
set foldlevel=99
set lines=999
set columns=130
set wrapscan            " search fron beginning if end of file is reached

call plug#begin('~/.vim/bundle')
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'mhinz/vim-signify'
Plug 'mhinz/vim-startify'             " Startup screen when opening vim
Plug 'kien/ctrlp.vim'
Plug 'sjl/gundo.vim'
Plug 'Valloric/YouCompleteMe'
Plug 'scrooloose/syntastic'
Plug 'Raimondi/delimitMate'
Plug 'bling/vim-airline'
Plug 'ivyl/vim-bling'
Plug 'alfredodeza/pytest.vim'
Plug 'scrooloose/nerdtree'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'             " Snippets are not part of the ultisnips plugin
Plug 'ludovicchabant/vim-lawrencium'
Plug 'kien/rainbow_parentheses.vim'
Plug 'justinmk/vim-sneak'
Plug 'hynek/vim-python-pep8-indent'
Plug 'ervandew/supertab'
Plug 'mbbill/undotree'
Plug 'haya14busa/incsearch.vim'
Plug 'majutsushi/tagbar'
Plug 'elzr/vim-json'
" Themes
Plug 'zoresvit/vim-colors-solarized'  " Has the fix with the left bar)
Plug 'NLKNguyen/papercolor-theme'
Plug 'chriskempson/base16-vim'
Plug 'morhetz/gruvbox'
Plug 'gilgigilgil/anderson.vim'
Plug 'junegunn/seoul256.vim'
call plug#end()
"""""""""""""""""""" Signify OPTIONS
let g:signify_vcs_list = [ 'hg', 'git' ]
let g:signify_mapping_toggle_highlight = '<leader>sy'

"""""""""""""""""""" Airline OPTIONS
let g:airline_powerline_fonts = 1                       " Support powerline fonts
let g:airline_theme = 'gruvbox'                          " Theme for airline
let g:airline_extensions = ['branch', 'tabline', 'whitespace']
let g:airline#extensions#branch#enabled = 1            " enable tabline
let g:airline#extensions#tabline#enabled = 1            " enable tabline
let g:airline#extensions#tabline#fnamemod = ':t'        " show only filename
let g:airline#extensions#tabline#tab_nr_type = 1        " tab number type

""""""""""""""""""" CtrlP OPTIONS
" Custom ignore files/folders for CtrlP
let g:ctrlp_working_path_mode = 'c'
let g:ctrlp_custom_ignore = {
    \ 'dir': '\v[\/]\.(git|hg)$',
    \ 'file': '\v\.(mp4|bson|mp3|jpg|png)$',
    \ }

"""""""""""""""""" SYNTASTIC OPTIONS
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_python_pylama_args = '-l pep257,pyflakes,pylint,pep8'
let g:syntastic_python_checkers = ['pylama']

" Syntastic shows ~ underline for warnings/errors, so disable it.
highlight SyntasticWarning NONE
highlight SyntasticError NONE

"""""""""""""""""" UltiSnips OPTIONS
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"


""""""""""""""""""" NERD-tree plugin
" Close vim when only NERDtree is left
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
" Shortcut to open NERD-tree Ctrl+n
map <C-n> :NERDTreeToggle<CR>
let NERDTreeIgnore = ['\.pyc$', '__pycache__$[[dir]]']        " Dont show .pyc files or __pycache__ folders in tree
let g:NERDTreeWinSize=17                                      " Size of NERTree


""""""""""""""""""" STARTIFY plugin
let g:startify_bookmarks = [ '~/.vimrc' ]


" ==========================================================
" Shortcuts
" ==========================================================
let mapleader = ","             " change the leader to be a comma vs slash

" Fix for Python comments when inserting # removes the indentation
inoremap # X#
" sudo write this
cmap W! w !sudo tee % >/dev/null

" Reload Vimrc
map <silent> <leader>V :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>

" open/close the quickfix window
nmap <leader>c :copen<CR>
nmap <leader>cc :cclose<CR>
set backspace=indent,eol,start
" for when we forget to use sudo to open/edit a file
cmap w!! w !sudo tee % >/dev/null

" ctrl-jklm  changes to that split
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" and lets make these all work in insert mode too ( <C-O> makes next cmd
"  happen as if in command mode )
imap <C-W> <C-O><C-W>

" Load the Gundo window
map <leader>g :GundoToggle<CR>

" When splitting new tab opens to the right of the current tab
set splitright

" ==========================================================
" Basic Settings
" ==========================================================

" Relative in Normal, Absolute in Insert
set relativenumber
autocmd InsertEnter * :set norelativenumber
autocmd InsertEnter * :set number
autocmd InsertLeave * :set relativenumber

set wildmenu                  " Menu completion in command mode on <Tab>
set wildmode=full             " <Tab> cycles between all matching choices.
set guioptions -=m            " Removes the menubar from gVim
set guioptions -=T            " Removes the toolbar from gVim
set guioptions -=r            " Removes right-hand rollabar
set guioptions -=L            " Removes left-hand rollbar
set enc=utf-8                 " the best all-purpose encoding

" don't bell or blink
"set noerrorbells
"set vb t_vb=                 " Commented it cause it was flashing at
"points the screen

" Ignore these files when completing
set wildignore+=*.o,*.obj,.git,*.pyc
set wildignore+=eggs/**
set wildignore+=*.egg-info/**

" Set working directory
nnoremap <leader>. :lcd %:p:h<CR>


""" Moving Around/Editing
set cursorline              " have a line indicate the cursor location
set nostartofline           " Avoid moving cursor to BOL when jumping around
set virtualedit=block       " Let cursor move past the last char in <C-v> mode
set scrolloff=3             " Keep 3 context lines above and below the cursor
set backspace=2             " Allow backspacing over autoindent, EOL, and BOL
set showmatch               " Briefly jump to a paren once it's balanced
set nowrap
:au BufNewFile,BufRead *.py set textwidth=79 "Wrap text only in python files
"set colorcolumn=80          " Fill color the 80th column
" After 79 char make background brighter, has to be AFTER colorcolumn(only
" python files
au BufEnter * if &ft == 'python' | let &cc = join(range(80, 999),',') | else | set cc= | endif
set formatoptions+=t
set linebreak               " don't wrap textin the middle of a word
set autoindent              " always set autoindenting on
set smartindent             " use smart indent if thereis no indent file
set tabstop=4               " <tab> inserts 4 spaces
set shiftwidth=4            " an indent level is 4 spaces wide.
set softtabstop=4           " <BS> over an autoindent deletes both spaces.
set expandtab               " Use spaces, not tabs, for autoindent/tab key.
set shiftround              " rounds indent to a multiple of shiftwidth

"""" Reading/Writing

set autowrite               " Stop complaining about unsaved buffers
set autowriteall
set noautoread              " Don't automatically re-read changed files.

"""" Messages, Info, Status
set showcmd                 " Show incomplete normal mode commands as I type.
set report=0                " : commands always print changed line count.
set shortmess+=a            " Use [+]/[RO]/[w] for modified/readonly/written.
set ruler                   " Show some info, even without statuslines.
set laststatus=2            " Always show statusline, even if only 1 window.

""" Searching and Patterns
set ignorecase              " Default to using case insensitive searches,
set smartcase               " unless uppercase letters are used in the regex.
set hlsearch                " Highlight searches by default.
au InsertEnter * set nohlsearch " Removes highlight when in insert and...
au InsertLeave * set hlsearch   " ...re-highlights when in normal mode again
set incsearch               " Incrementally search while typing a /regex

" Paste from clipboard
map <leader>p "+p
" Copy to clipboard
map <leader>y "+y

" hide matches on <leader>space
nnoremap <leader><space> :nohlsearch<cr>

" Select the item in the list with enter
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Disable Arrow Keys in Normal mode
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
" Disable Arrow Keys in Insert mode
inoremap <Up> <Nop>
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>

" Map the TAB key to go to the next tab(Shift+Tab for previous)
noremap <Tab> :tabnext<CR>
noremap <S-Tab> :tabprevious<CR>

" Colorscheme / Highlighting
"let g:solarized_degrade = 1

syntax on
"set t_Co=256
"let base16colorspace=256
set background=dark
colorscheme gruvbox

set guifont=Droid\ Sans\ Mono\ for\ Powerline\ 14
set linespace=5

" Automatic hide the tip window when on auto-complete
autocmd CompleteDone * pclose

set noswapfile
if exists("+undofile")
  " undofile - This allows you to use undos after exiting and restarting
  " This, like swap and backups, uses .vim-undo first, then ~/.vim/undo
  " :help undo-persistence
  " This is only present in 7.3+
  if isdirectory($HOME . '/.vim/undo') == 0
    :silent !mkdir -p ~/.vim/undo > /dev/null 2>&1
  endif
  set undodir=./.vim-undo//
  set undodir+=~/.vim/undo//
  set undofile
endif

" This beauty remembers where you were the last time you edited the file, and returns to the same position.
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

" Save a session and reopen it
map <F2> :mksession! ~/vim_session <cr> " Quick write session with F2
map <F3> :source ~/vim_session <cr>     " And load session with F3

" Block shape for cursor when in insert mode
set guicursor+=i:block-Cursor

" Map import pdb;pdb.set_trace() to leader b and B cause i use it all the time
" in Python scripts.
map <silent> <leader>b oimport pdb; pdb.set_trace()<esc>
map <silent> <leader>B Oimport pdb; pdb.set_trace()<esc>

" Rainbow parenthesis always on
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" delimitMate options
let delimitMate_nesting_quotes = ['"','`']
au FileType python let b:delimitMate_nesting_quotes = ['"']
