let g:python_host_prog = '/usr/bin/python2'
let g:python3_host_prog = '/usr/bin/python3'
set path+=**

call plug#begin('~/.config/nvim/plugged')
" ------------------------------------------------------------------ Generic
Plug 'ludovicchabant/vim-gutentags'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
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
Plug 'zchee/deoplete-jedi',            { 'do': 'git submodule update --init', 'for': ['python'] }
" ------------------------------------------------------------------ File search
Plug 'junegunn/fzf',                   { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" ------------------------------------------------------------------ History
Plug 'mbbill/undotree',                { 'on': 'UndotreeToggle'   }
" ------------------------------------------------------------------ Linters/Highlight
Plug 'benekastah/neomake'
Plug 'w0rp/ale'
Plug 'maximbaz/lightline-ale'
Plug 'Glench/Vim-Jinja2-Syntax',       { 'for': 'html' }
" ------------------------------------------------------------------ Surroundings
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'
Plug 'alvan/vim-closetag',             { 'for': 'html' }
Plug 'luochen1990/rainbow',            { 'on': 'RainbowToggle' }
" ------------------------------------------------------------------ Version Control
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim',                { 'on': 'GV' }
Plug 'airblade/vim-gitgutter' " or 'mhinz/vim-signify' if mercurial is needed
Plug 'elzr/vim-json',                  { 'for': 'json' }
" ------------------------------------------------------------------ Effects
Plug 'inside/vim-search-pulse'
Plug 'yuttie/comfortable-motion.vim'
Plug 'machakann/vim-highlightedyank'
" ------------------------------------------------------------------ Interface
Plug 'mhinz/vim-startify'
Plug 'itchyny/lightline.vim'
Plug 'ap/vim-buftabline'
" ------------------------------------------------------------------ Colorschemes
"Plug 'NLKNguyen/papercolor-theme'
"Plug 'morhetz/gruvbox'
"Plug 'mhartington/oceanic-next' " best for dark
"Plug 'reedes/vim-colors-pencil' " best for light
Plug 'ev-agelos/vim-deep-space'
"Plug 'metalelf0/base16-black-metal-scheme'
Plug 'xero/blaquemagick.vim'
call plug#end()

" ----------------------------------------------------------
"                    Colorschemes
" ----------------------------------------------------------
"set termguicolors " use 24-bit color

" ------------------ Gruvbox -------------------------------
"let g:gruvbox_contrast_dark='soft'

" ------------------ Oceanic -------------------------------
" let g:oceanic_next_terminal_italic = 1
" let g:oceanic_next_terminal_bold = 1
" colorscheme OceanicNextLight

" ------------------ Pencil --------------------------------
" let g:pencil_gutter_color = 1
" let g:pencil_neutral_headings = 1
" let g:pencil_higher_contrast_ui = 1
" let g:pencil_terminal_italics = 1
" let g:pencil_spell_undercurl = 0
" colorscheme pencil
" ------------------ Deep space ---------------------------
" let g:deepspace_italics=1
"colorscheme deep-space
" ------------------ Blaquemagick
colorscheme blaquemagick

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

" supertab
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabDefaultCompletionType = "<c-n>"

" vim-bbye
nnoremap <Leader>q :silent Bdelete<CR>

" Gutentags
let g:gutentags_cache_dir='~/.tags'

" JSON plugin
let g:vim_json_syntax_conceal = 0 " Disable the effect from hiding the actual code

" UndoToggle
map <leader>u :UndotreeToggle<CR>

" Incsearch
let g:incsearch#magic = '\V'
let g:incsearch#auto_nohlsearch = 1
map / <Plug>(incsearch-stay)
map <leader>/ /\v

" Deoplete
let g:deoplete#enable_at_startup = 0
augroup insertload
  autocmd!
  autocmd InsertEnter * call deoplete#enable() | autocmd! insertload
augroup END
let g:deoplete#sources#jedi#show_docstring = 1
call deoplete#custom#source('_', 'matchers', ['matcher_fuzzy', 'matcher_length']) " don't show the type word in the list

" Signify
let g:signify_vcs_list = [ 'hg', 'git' ]

" BufTabline
let g:buftabline_numbers=2
nmap <leader>1 <Plug>BufTabLine.Go(1)
nmap <leader>2 <Plug>BufTabLine.Go(2)
nmap <leader>3 <Plug>BufTabLine.Go(3)
nmap <leader>4 <Plug>BufTabLine.Go(4)
nmap <leader>5 <Plug>BufTabLine.Go(5)
nmap <leader>6 <Plug>BufTabLine.Go(6)
nmap <leader>7 <Plug>BufTabLine.Go(7)
nmap <leader>8 <Plug>BufTabLine.Go(8)
nmap <leader>9 <Plug>BufTabLine.Go(9)
nmap <leader>0 <Plug>BufTabLine.Go(10)

" Lightlime
let g:lightline = {
      \ 'colorscheme': 'deepspace',
      \ 'separator': { 'left': '', 'right': '' },
	  \ 'subseparator': { 'left': '', 'right': '' },
      \ 'enable': {'tabline': 0},
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive' ],
      \             [ 'absolutepath', 'mymodified', 'readonly'] ],
      \   'right': [ [ 'linter_errors', 'linter_warnings'],
      \              [ 'tags' ],
      \              [ 'column'],
      \              [ 'fileencoding' ],
      \              [ 'filetype' ]]
      \ },
      \ 'inactive': {
      \   'left': [ [ 'absolutepath'] ],
      \   'right': []
      \ },
      \ 'component': {
      \   'tags': '%{gutentags#statusline(" ")}',
      \   'readonly': '%{&filetype=="help"?"":&readonly?"":""}',
      \   'fugitive': '%{exists("*fugitive#head") && ""!=fugitive#head()?" ".fugitive#head():""}'
      \ },
      \ 'component_expand': {
      \   'mymodified': 'LightlineModified',
      \   'linter_warnings': 'lightline#ale#warnings',
      \   'linter_errors': 'lightline#ale#errors',
      \ },
      \ 'component_type': {
      \   'linter_warnings': 'warning',
      \   'linter_errors': 'error',
      \ }
      \ }

function! LightlineModified()
    return &modifiable && &modified ? '[+]' : ''
endfunction
" ALE
let g:ale_lint_on_enter = 0                                    " don't lint when opening file
let g:ale_lint_on_save = 1                                     " lint when saving file
let g:ale_fix_on_save = 1                                      " fix when saving file
let g:ale_emit_conflict_warnings = 0                            " avoid conflicts with NeoMake
let g:ale_sign_warning='●'
let g:ale_sign_error='●'
let g:ale_sign_column_always = 1
let g:ale_set_highlights = 0
let g:ale_echo_msg_format = '%linter% %s'
hi ALEErrorSign ctermbg=234 ctermfg=88 cterm=NONE
hi ALEWarningSign ctermbg=234 ctermfg=250 cterm=NONE

let g:ale_linters = {
\   'python': ['pylint', 'flake8'],
\}
let g:ale_python_pylint_options = "--rcfile ~/.pylintrc"
let g:ale_python_flake8_options = "--max-line-length=100"
" Bind F8 to fixing problems with ALE
nmap <F8> <Plug>(ale_fix)
let g:ale_fixers = {
\   'python': ['isort']
\}

" Neomake
let g:neomake_highlight_columns=0
let g:neomake_warning_sign = {'text': '●', 'texthl': 'NeomakeWarningSign'}
let g:neomake_error_sign = {'text': '●', 'texthl': 'NeomakeErrorSign'}
let g:neomake_python_enabled_makers = ['pydocstyle', 'pylint', 'flake8']
au! BufWritePost * Neomake

" Startify
let g:startify_change_to_vcs_root = 1
let g:startify_update_oldfiles = 1
let g:startify_session_dir = '~/.config/nvim/session'
let g:startify_bookmarks = [ '~/.config/nvim/init.vim' ]
let g:startify_custom_header = []
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
  \   'rg --column --line-number --no-heading --fixed-strings --smart-case --hidden --follow --color=always --no-messages '.shellescape(<q-args>), 1,
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
set sidescrolloff=5                 " Same as scrolloff but for columns
set sidescroll=1
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
set hidden
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
" move down/up by display, but keep regular up/down
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k
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
"                    Custom
" ----------------------------------------------------------
au! FileType python setl nosmartindent              " Disable smartindent in python files(messing up hash commenting symbol)
au BufNewFile,BufRead *.py setlocal textwidth=99    " Wrap text only in python files
highlight ColorColumn guibg=#252c3a
au BufNewFile,BufRead *.py setlocal colorcolumn=80
au CompleteDone * pclose                            " Automatic hide the tip window when on auto-complete
au InsertEnter * set nohlsearch                     " Removes highlight when in insert mode
autocmd FileType latex,tex,md,markdown setlocal spell " turn on spell checker for certain file types

" Disable highlighting in Insert mode for parenthesis, brackets etc..
au! InsertEnter * NoMatchParen
au! InsertLeave * DoMatchParen

autocmd BufWritePre * %s/\s\+$//e                   " trim whitespace on save
autocmd FileType python autocmd BufWritePre <buffer> :%s/\($\n\s*\)\+\%$//e

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

hi DiffAdd     gui=none    guifg=#709d6c          guibg=#2d422b
hi DiffChange   gui=none    guifg=NONE          guibg=NONE
hi DiffDelete   gui=bold    guifg=#ff8080       guibg=NONE
hi DiffText     gui=none    guifg=#709d6c          guibg=#2d422b
