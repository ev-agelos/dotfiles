let g:python3_host_prog = 'python3'
set path+=**

call plug#begin('~/.config/nvim/plugged')
" ------------------------------------------------------------------ Generic
Plug 'ludovicchabant/vim-gutentags'
Plug 'tpope/vim-repeat'
Plug 'justinmk/vim-dirvish'
Plug 'haya14busa/incsearch.vim'
Plug 'ervandew/supertab'
Plug 'christoomey/vim-tmux-navigator'
Plug 'moll/vim-bbye'
Plug 'hynek/vim-python-pep8-indent',   { 'for': 'python' }
" ------------------------------------------------------------------ Unix shell commands
Plug 'tpope/vim-eunuch'
" ------------------------------------------------------------------ Completion
Plug 'Shougo/deoplete.nvim',           { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-jedi',            { 'do': 'git submodule update --init' }
" ------------------------------------------------------------------ File search
Plug 'junegunn/fzf',                   { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" ------------------------------------------------------------------ History
Plug 'mbbill/undotree',                { 'on': 'UndotreeToggle'   }
" ------------------------------------------------------------------ Linters/Highlight
Plug 'benekastah/neomake'
Plug 'w0rp/ale'
Plug 'Glench/Vim-Jinja2-Syntax',       { 'for': 'html' }
" ------------------------------------------------------------------ Surroundings
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'
Plug 'alvan/vim-closetag',             { 'for': 'html' }
Plug 'luochen1990/rainbow'
" ------------------------------------------------------------------ Version Control
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim',                { 'on': 'GV' }
Plug 'airblade/vim-gitgutter' " or 'mhinz/vim-signify' if mercurial is needed
Plug 'elzr/vim-json',                  { 'for': 'json' }
" ------------------------------------------------------------------ Effects
Plug 'inside/vim-search-pulse'
Plug 'yuttie/comfortable-motion.vim'
Plug 'junegunn/limelight.vim',         { 'on': 'Limelight' }
Plug 'junegunn/goyo.vim',              { 'on': 'Goyo' }
" ------------------------------------------------------------------ Interface
Plug 'mhinz/vim-startify'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" ------------------------------------------------------------------ Colorschemes
Plug 'frankier/neovim-colors-solarized-truecolor-only'
"Plug 'NLKNguyen/papercolor-theme'
Plug 'morhetz/gruvbox'
Plug 'mhartington/oceanic-next' " best for dark
Plug 'reedes/vim-colors-pencil' " best for light
Plug 'arcticicestudio/nord-vim'
Plug 'tyrannicaltoucan/vim-deep-space'
call plug#end()

" ----------------------------------------------------------
"                       Leader
" ----------------------------------------------------------
" Use , as the leader key
let mapleader = ","
" hide matches on <leader>space
nnoremap <leader><space> :nohlsearch<cr>
" Map import pdb;pdb.set_trace() to leader b and B cause i use it all the time in Python scripts.
map <silent> <leader>b oimport pdb; pdb.set_trace()<esc>
map <silent> <leader>B Oimport pdb; pdb.set_trace()<esc>


" ----------------------------------------------------------
"                     Plugin options
" ----------------------------------------------------------

" Gutentags
let g:gutentags_ctags_tagfile='.git/tags'
set statusline+=%{gutentags#statusline('[Generating...]')}
" delimitMate
let delimitMate_nesting_quotes = ['"','`']
au FileType python let b:delimitMate_nesting_quotes = ['"']
" Rainbow
let g:rainbow_active = 1
" JSON plugin
let g:vim_json_syntax_conceal = 0 " Disable the effect from hiding the actual code
" NORD colorscheme
let g:nord_italic_comments = 1
" MundoToggle
map <leader>g :MundoToggle<CR>
" Incsearch
map / <Plug>(incsearch-stay)
" Deoplete
let g:deoplete#enable_at_startup = 1
" Signify
let g:signify_vcs_list = [ 'hg', 'git' ]
" Airline
let g:airline_section_z = '%c'
let g:airline_powerline_fonts = 1                              " Support powerline fonts
let g:airline_theme = 'oceanicnext'                                   " Theme for airline
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_extensions = ['branch', 'whitespace', 'tabline', 'ale']
" ale
let g:ale_emit_conflict_warnings = 0                            " avoid conflicts with NeoMake
let g:ale_sign_warning='●'
let g:ale_sign_error='●'
hi link ALEErrorSign    Error
hi link ALEWarningSign  Warning

let g:ale_linters = {
\   'python': ['pylint', 'flake8'],
\}
let g:ale_fixers = {
\   'python': ['autopep8', 'isort', 'yapf']
\}
let g:ale_sign_column_always = 1
let g:ale_echo_msg_format = '%linter% %s'
" Neomake
let g:neomake_highlight_columns=0
let g:neomake_python_enabled_makers = ['pydocstyle']
au! BufWritePost * Neomake
" Startify
let g:startify_change_to_vcs_root = 1
let g:startify_session_dir = '~/.config/nvim/session'
let g:startify_bookmarks = [ '~/.config/nvim/init.vim' ]
let g:startify_custom_header = []
          "\ map(split(system('fortune | cowsay'), '\n'), '"   ". v:val') + ['']
let g:startify_list_order = [
        \ ['   Bookmarks:'],
        \ 'bookmarks',
        \ ['   Sessions:'],
        \ 'sessions',
        \ ['   MRU:'],
        \ 'dir',
        \ ['   Files'],
        \ 'files'
        \ ]
" fzf-vim
let g:fzf_files_options =
   \ '--preview "(coderay {} || cat {}) 2> /dev/null | head -'.&lines.'"'
" press ? to open preview when on :Rg.
" Note for linux mint: remove the highlight part from the COMMAND variable
" defined in ~/.config/nvim/plugged/fzf.vim/bin/preview.rb for this to work!
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --fixed-strings --smart-case --no-ignore --hidden --follow --color=always --no-messages '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

" ---------------------------------------------------------
"                    Settings
" ---------------------------------------------------------
set foldmethod=indent
set foldlevel=99
set splitright                   " When vertically split right
set splitbelow                   " When horizontally split below
set sidescroll=1
set mouse=a
set number
set wildmode=full                " <Tab> cycles between all matching choices.

" --------------- Moving Around/Editing --------------------
" Do not blink in normal mode, Use pipe shape in insert mode
set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor
set clipboard+=unnamedplus       " Copy/Paste always to clipboard
set cursorline                   " have a line indicate the cursor location
set nostartofline                " Avoid moving cursor to BOL when jumping around
set virtualedit=block            " Let cursor move past the last char in <C-v> mode
set scrolloff=3                  " Keep 3 context lines above and below the cursor
set backspace=2                  " Allow backspacing over autoindent, EOL, and BOL
set showmatch                    " Briefly jump to a paren once it's balanced
set nowrap
set formatoptions+=t
set linebreak                    " don't wrap textin the middle of a word
set smartindent                  " use smart indent if thereis no indent file
set tabstop=4                    " <tab> inserts 4 spaces
set shiftwidth=4                 " an indent level is 4 spaces wide.
set softtabstop=4                " <BS> over an autoindent deletes both spaces.
set expandtab                    " Use spaces, not tabs, for autoindent/tab key.
set shiftround                   " rounds indent to a multiple of shiftwidth
set inccommand=split

" ------------------Reading/Writing--------------------------
set noswapfile
set autowrite                    " Stop complaining about unsaved buffers
set autowriteall
set noautoread                   " Don't automatically re-read changed files.

" ------------------Messages, Info, Status-------------------
set showcmd                      " Show incomplete normal mode commands as I type.
set report=0                     " : commands always print changed line count.
set shortmess+=a                 " Use [+]/[RO]/[w] for modified/readonly/written.
set ruler                        " Show some info, even without statuslines.


" ------------------Searching and Patterns-------------------
set wrapscan                     " search fron beginning if end of file is reached
set ignorecase                   " Default to using case insensitive searches,
set smartcase                    " unless uppercase letters are used in the regex.
" Ignore these files when completing
set wildignore+=*.o,*.obj,.git,*.pyc
set wildignore+=eggs/**
set wildignore+=*.egg-info/**
set noshowmode                   " Hide vim mode from status line

" ----------------------------------------------------------
"                    Mappings
" ----------------------------------------------------------
" fzf
nnoremap <C-p> :Files<cr>
nnoremap \ :Rg<SPACE>
" Mappings for NeoVim's terminal
tnoremap <Esc> <C-\><C-n>
" No need for Ex mode
nnoremap Q <nop>
" recording mappings is not my thing
map q <Nop>
" Select the item in the list with enter
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Map the TAB key to go to the next tab(Shift+Tab for previous)
noremap <silent> <Tab> :bnext<CR>
noremap <silent> <S-Tab> :bprevious<CR>
" Center screen when jumping to next match
noremap n nzz
noremap N Nzz
" Don't yank to default register when changing something
nnoremap c "xc
xnoremap c "xc
" No more accidentally showing up command window (Use C-f to show it)
map q: :q
" Keep selection when moving blocks
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
vnoremap < <gv
vnoremap > >gv

" ----------------------------------------------------------
"                    Colorschemes
" ----------------------------------------------------------
set termguicolors " use 24-bit color
syntax on

" ------------------ Gruvbox -------------------------------
"let g:gruvbox_contrast_dark='soft'

" ------------------ Oceanic -------------------------------
"let g:oceanic_next_terminal_italic = 1
"let g:oceanic_next_terminal_bold = 1

" ------------------ Pencil --------------------------------
"let g:pencil_gutter_color = 1
"let g:pencil_neutral_headings = 1
"let g:pencil_higher_contrast_ui = 1
"let g:pencil_terminal_italics = 1
"let g:pencil_spell_undercurl = 0
" ------------------ Deep space ---------------------------
let g:deepspace_italics=1

set background=dark
colorscheme deep-space

" ----------------------------------------------------------
"               NeoVim Terminal colors
" ----------------------------------------------------------
" Set the color pallete of the terminal.
let g:terminal_color_0  = '#3B4252'
let g:terminal_color_1  = '#BF616A'
let g:terminal_color_2  = '#A3BE8C'
let g:terminal_color_3  = '#EBCB8B'
let g:terminal_color_4  = '#81A1C1'
let g:terminal_color_5  = '#B48EAD'
let g:terminal_color_6  = '#88C0D0'
let g:terminal_color_7  = '#E5E9F0'
let g:terminal_color_8  = '#4C566A'
let g:terminal_color_9  = '#BF616A'
let g:terminal_color_10 = '#A3BE8C'
let g:terminal_color_11 = '#EBCB8B'
let g:terminal_color_12 = '#81A1C1'
let g:terminal_color_13 = '#B48EAD'
let g:terminal_color_14 = '#8FBCBB'
let g:terminal_color_15 = '#ECEFF4'
" ----------------------------------------------------------
"                    Custom
" ----------------------------------------------------------
au! FileType python setl nosmartindent              " Disable smartindent in python files(messing up hash commenting symbol)
au BufWritePre * :%s/\s\+$//e                       " Remove tailing spaces upon saving the file
au BufNewFile,BufRead *.py setlocal textwidth=99    " Wrap text only in python files
highlight ColorColumn guibg=#252c3a
au BufNewFile,BufRead *.py setlocal colorcolumn=80
au CompleteDone * pclose                            " Automatic hide the tip window when on auto-complete
au InsertEnter * set nohlsearch                     " Removes highlight when in insert mode

" Disable highlighting in Insert mode for parenthesis, brackets etc..
"au! InsertEnter * NoMatchParen
"au! InsertLeave * DoMatchParen

if exists("+undofile")
  " undofile - This allows you to use undos after exiting and restarting
  " This, like swap and backups, uses .vim-undo first, then ~/.vim/undo
  " :help undo-persistence
  " This is only present in 7.3+
  if isdirectory($HOME . '/.config/nvim/undo') == 0
    :silent !mkdir -p ~/.config/nvim/undo > /dev/null 2>&1
  endif
  set undodir=./.nvim-undo//
  set undodir+=~/.nvim/undo//
  set undofile
endif

" This beauty remembers where you were the last time you edited the file, and returns to the same position.
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif
