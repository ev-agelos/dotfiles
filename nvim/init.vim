set foldmethod=indent
set foldlevel=99
set wrapscan            " search fron beginning if end of file is reached

call plug#begin('~/.config/nvim/plugged')
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'mhinz/vim-signify'
Plug 'mhinz/vim-startify'             " Startup screen when opening vim
Plug 'kien/ctrlp.vim'
Plug 'simnalamburt/vim-mundo'         " Fork of Gundo compatible with NeoVim
Plug 'benekastah/neomake'
Plug 'Raimondi/delimitMate'
Plug 'bling/vim-airline'
Plug 'zefei/vim-wintabs'
Plug 'ivyl/vim-bling'
Plug 'scrooloose/nerdtree'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'             " Snippets are not part of the ultisnips plugin
Plug 'ludovicchabant/vim-lawrencium'
Plug 'kien/rainbow_parentheses.vim'
Plug 'hynek/vim-python-pep8-indent'
Plug 'ervandew/supertab'
Plug 'mbbill/undotree'
Plug 'haya14busa/incsearch.vim'
Plug 'elzr/vim-json'
Plug 'kshenoy/vim-signature'          " Place marks on files
" Themes
Plug 'zoresvit/vim-colors-solarized'  " Has the fix with the left bar)
Plug 'NLKNguyen/papercolor-theme'
Plug 'chriskempson/base16-vim'
Plug 'morhetz/gruvbox'
Plug 'gilgigilgil/anderson.vim'
Plug 'junegunn/seoul256.vim'
call plug#end()


"""""""""""""""""""""""""""""""""""
""""""""""""""""""" Signify OPTIONS
"""""""""""""""""""""""""""""""""""
let g:signify_vcs_list = [ 'hg', 'git' ]

"""""""""""""""""""" Airline OPTIONS
let g:airline_powerline_fonts = 1                       " Support powerline fonts
let g:airline_theme = 'gruvbox'                          " Theme for airline
let g:airline_extensions = ['branch', 'whitespace']
let g:airline#extensions#branch#enabled = 1            " enable tabline

"""""""""""""""""""""""""""""""""""
""""""""""""""""""" CtrlP OPTIONS
"""""""""""""""""""""""""""""""""""
" Custom ignore files/folders for CtrlP
let g:ctrlp_working_path_mode = 'c'
let g:ctrlp_custom_ignore = {
    \ 'dir': '\v[\/]\.(git|hg)$',
    \ 'file': '\v\.(mp4|bson|mp3|jpg|png)$',
    \ }

"""""""""""""""""""""""""""""""""""
""""""""""""""""""" NEOMAKE options
"""""""""""""""""""""""""""""""""""
let g:neomake_python_enabled_makers = ['pylama', 'pylint', 'pep8', 'pyflakes', 'python']
autocmd! BufWritePost * Neomake

"""""""""""""""""""""""""""""""""""
"""""""""""""""""" UltiSnips OPTIONS
"""""""""""""""""""""""""""""""""""
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"


"""""""""""""""""""""""""""""""""""
""""""""""""""""""" NERD-tree plugin
"""""""""""""""""""""""""""""""""""
" Close vim when only NERDtree is left
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
" Shortcut to open NERD-tree Ctrl+n
map <C-n> :NERDTreeToggle<CR>
let NERDTreeIgnore = ['\.pyc$', '__pycache__$[[dir]]']        " Dont show .pyc files or __pycache__ folders in tree
let g:NERDTreeWinSize=17                                      " Size of NERTree


"""""""""""""""""""""""""""""""""""
""""""""""""""""""" STARTIFY plugin
"""""""""""""""""""""""""""""""""""
let g:startify_bookmarks = [ '~/.config/nvim/init.vim' ]
let g:startify_custom_header =
          \ map(split(system('fortune | cowsay'), '\n'), '"   ". v:val') + ['']

"""""""""""""""""""""""""""""""""""
""""""""""""""""""" JSON plugin
"""""""""""""""""""""""""""""""""""
"Disable the effect from hiding the actual code
let g:vim_json_syntax_conceal = 0





" ==========================================================
" Shortcuts
" ==========================================================
let mapleader = ","             " change the leader to be a comma vs slash

" Fix for Python comments when inserting # removes the indentation
inoremap # X#<Space>
" sudo write this
cmap W! w !sudo tee % >/dev/null

" Reload init.vim
map <silent> <leader>V :source ~/.config/nvim/init.vim<CR>:filetype detect<CR>:exe ":echo 'init.vim reloaded'"<CR>

" for when we forget to use sudo to open/edit a file
cmap w!! w !sudo tee % >/dev/null

" ctrl-jklm  changes to that split
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h


" Load the Mundo window
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



set wildmode=full             " <Tab> cycles between all matching choices.
" Ignore these files when completing
set wildignore+=*.o,*.obj,.git,*.pyc
set wildignore+=eggs/**
set wildignore+=*.egg-info/**

set noshowmode              " Hide vim mode from status line

""" Moving Around/Editing
set clipboard+=unnamedplus  " Copy/Paste always to clipboard
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

""" Searching and Patterns
set ignorecase              " Default to using case insensitive searches,
set smartcase               " unless uppercase letters are used in the regex.
au InsertEnter * set nohlsearch " Removes highlight when in insert and...
au InsertLeave * set hlsearch   " ...re-highlights when in normal mode again

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
noremap <silent> <Tab> :tabnext<CR>
noremap <silent> <S-Tab> :tabprevious<CR>
" Buffers navigation and management
nnoremap <silent> <Right> :bn<CR>
nnoremap <silent> <Left> :bp<CR>

" Remap Esc
inoremap jk <Esc>
inoremap kj <Esc>

" When jump to next match also center screen
noremap n nzz
noremap N Nzz
" Don't yank to default register when changing something
nnoremap c "xc
xnoremap c "xc
" No more accidentally showing up command window (Use C-f to show it)
map q: :q
" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv


" Colorscheme / Highlighting
"let g:solarized_degrade = 1
syntax on
"let base16colorspace=256
set background=dark
colorscheme gruvbox

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
