let g:python_host_prog = '/usr/bin/python2'
let g:python3_host_prog = '/usr/bin/python3'
set path+=**

call plug#begin('~/.config/nvim/plugged')
" ------------------------------------------------------------------ Generic
Plug 'majutsushi/tagbar',              { 'on': 'TagbarToggle' }
Plug 'ludovicchabant/vim-gutentags'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'justinmk/vim-dirvish'
Plug 'haya14busa/incsearch.vim'
Plug 'google/vim-searchindex'
Plug 'hynek/vim-python-pep8-indent',   { 'for': 'python' }
Plug 'skywind3000/asyncrun.vim'
" ------------------------------------------------------------------ Unix shell commands
Plug 'tpope/vim-eunuch'
Plug 'lambdalisue/suda.vim'
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
Plug 'Glench/Vim-Jinja2-Syntax',       { 'for': 'html' }
" ------------------------------------------------------------------ Surroundings
Plug 'tpope/vim-commentary'
Plug 'machakann/vim-sandwich'
Plug 'jiangmiao/auto-pairs'
Plug 'alvan/vim-closetag',             { 'for': 'html' }
" ------------------------------------------------------------------ Version Control
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim',                { 'on': 'GV' }
Plug 'airblade/vim-gitgutter' " or 'mhinz/vim-signify' if mercurial is needed
Plug 'elzr/vim-json',                  { 'for': 'json' }
" ------------------------------------------------------------------ Effects
Plug 'yuttie/comfortable-motion.vim'
Plug 'machakann/vim-highlightedyank'
" ------------------------------------------------------------------ Interface
Plug 'mhinz/vim-startify'
Plug 'ap/vim-buftabline'
" ------------------------------------------------------------------ Colorschemes
Plug 'ThomasMarcel/vim-colors-plain'
Plug 'aunsira/macvim-light'
Plug 'ev-agelos/vim-deep-space'
Plug 'ev-agelos/blaquemagick.vim'
call plug#end()

" ----------------------------------------------------------
"                    Colorschemes
" ----------------------------------------------------------
set termguicolors " use 24-bit color
"set background=light
colorscheme blaquemagick

" ----------------------------------------------------------
"                       Leader
" ----------------------------------------------------------
" Use , as the leader key
let mapleader = ","
" search without escaping regex symbols
nnoremap <leader>/ /\v
" turn off search highlighting
nnoremap <leader>l :nohlsearch<cr>
" source config file
nnoremap <leader>s :source $MYVIMRC<cr>
" Map import pdb;pdb.set_trace() to leader b and B cause i use it all the time in Python scripts.
map <silent> <leader>b oimport pdb; pdb.set_trace()<esc>
map <silent> <leader>B Oimport pdb; pdb.set_trace()<esc>

" ----------------------------------------------------------
"                     Plugin options
" ----------------------------------------------------------

" tagbar
nmap <F8> :TagbarToggle<CR>
" auto-pairs
let g:AutoPairsMapBS = 0

" suda
command! -nargs=1 SudoRead  edit  suda://<args>
command! -nargs=1 SudoWrite write suda://<args>

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
map ? <Plug>(incsearch-backward)

" Deoplete
call deoplete#custom#option('max_list', 5)
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"
let g:deoplete#enable_at_startup = 0
let g:deoplete#sources#jedi#show_docstring = 1

augroup insertload
  autocmd!
  autocmd InsertEnter * call deoplete#enable() | autocmd! insertload
augroup END

call deoplete#custom#source('_', 'matchers', ['matcher_fuzzy', 'matcher_length']) " don't show the type word in the list

" Signify
let g:signify_vcs_list = [ 'git' ]

" BufTabline
let g:buftabline_numbers=2

" Neomake
let g:neomake_python_isort_maker = {
    \ 'exe': 'isort',
    \ }
"augroup my_neomake_hooks
"  au!
"  autocmd User NeomakeJobFinished :e
"augroup END
let g:neomake_highlight_columns=0
let g:neomake_python_pylint_args = [
    \ '--rcfile=~/.pylintrc',
    \ '--msg-template="{path}:{line}:{column}:{C}: [{symbol}] {msg} [{msg_id}]"',
    \ '--score=no',
    \ '--reports=no',
    \ ]

let g:neomake_warning_sign = {'text': '●', 'texthl': 'NeomakeWarningSign'}
let g:neomake_error_sign = {'text': '●', 'texthl': 'NeomakeErrorSign'}
let g:neomake_python_enabled_makers = ['pydocstyle', 'pylint', 'flake8']
au! BufWritePost * Neomake
hi NeomakeErrorSign ctermbg=234 ctermfg=88
hi NeomakeWarningSign ctermbg=234 ctermfg=250

function! NeomakeErrors()
  if !exists(":Neomake") || ((get(neomake#statusline#QflistCounts(), "E", 0) + get(neomake#statusline#LoclistCounts(), "E", 0)) == 0)
    return ''
  endif
  return 'E:'.(get(neomake#statusline#LoclistCounts(), 'E', 0) + get(neomake#statusline#QflistCounts(), 'E', 0))
endfunction

function! NeomakeWarnings()
  if !exists(":Neomake") || ((get(neomake#statusline#QflistCounts(), "W", 0) + get(neomake#statusline#LoclistCounts(), "W", 0)) == 0)
    return ''
  endif
  return 'W:'.(get(neomake#statusline#LoclistCounts(), 'W', 0) + get(neomake#statusline#QflistCounts(), 'W', 0))
endfunction

" Startify
nnoremap <leader>0 :Startify<cr>
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
nnoremap <C-p> :Files<cr>
nnoremap \ :Rg<SPACE>

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
" MRU with preview
command! -bang -nargs=* MRU call fzf#vim#history(fzf#vim#with_preview())

" ---------------------------------------------------------
"                    Settings
" ---------------------------------------------------------
set foldmethod=indent
set foldlevel=99
set splitright                   " When vertically split right
set splitbelow                   " When horizontally split below
set mouse=a
set wildmode=full                " <Tab> cycles between all matching choices.
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
set nojoinspaces                 " don't autoinsert two spaces after '.', '?', '!' for join command
set noswapfile
set hidden
set noautoread                   " Don't automatically re-read changed files.
set showcmd                      " Show incomplete normal mode commands as I type.
set report=0                     " : commands always print changed line count.
set shortmess+=a                 " Use [+]/[RO]/[w] for modified/readonly/written.
set ruler                        " Show some info, even without statuslines.
set wrapscan                     " search fron beginning if end of file is reached
set ignorecase                   " Default to using case insensitive searches,
set smartcase                    " unless uppercase letters are used in the regex.
set wildignore+=*.o,*.obj,.git,*.pyc
set wildignore+=eggs/**
set wildignore+=*.egg-info/**
set showmode                     " Show vim mode in status line
set undofile
set undodir=~/.config/nvim/undo
set undolevels=1000
set updatetime=1000
set statusline=%{gutentags#statusline('','','')}
set statusline+=%<%f
set statusline+=\ %h%{&modifiable\ &&\ &modified\ ?\ '[+]':''}%{&filetype=='help'?'':&readonly?'':''}%=
set statusline+=%{exists('*fugitive#head')\ &&\ ''!=fugitive#head()?''.fugitive#head():''}
set statusline+=%{NeomakeWarnings()}\ %{NeomakeErrors()}%=
set statusline+=%y\ %p%%\ %l,%c
"       \              [ 'fileencoding' ],
"       \ 'inactive': {
"       \   'left': [ [ 'absolutepath'] ],
"       \ 'component_expand': {
"       \   'dirpath': 'LightlineHomeDirPath',
set laststatus=0

" ----------------------------------------------------------
"                    Mappings
" ----------------------------------------------------------
" move down/up by display, but keep regular up/down
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k
" Mappings for NeoVim's terminal
tnoremap <Esc> <C-\><C-n>
" No need for Ex mode
nnoremap Q <nop>
" Select the item in the list with enter
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Center screen when jumping to next match
" noremap n nzz
" noremap N Nzz
" Don't yank to default register when changing something
nnoremap c "xc
xnoremap c "xc
" replace word under cursor and then with . apply downwards
nnoremap c* *``cgn
" replace word under cursor and then with . apply upwards
nnoremap c# #``cgN
" No more accidentally showing up command window (Use C-f to show it)
map q: :q
" Keep selection when moving blocks
vnoremap <Up> :m '<-2<CR>gv=gv
vnoremap <Down> :m '>+1<CR>gv=gv
vnoremap < <gv
vnoremap > >gv
" to next buffer
nnoremap ` :bnext<cr>
" to previous buffer
nnoremap <BS> :bprevious<cr>
nnoremap <leader><BS> <c-^>
" zoom in window
nnoremap <leader><leader> <c-w>_ \| <c-w>\|
" zoom out window
nnoremap <leader>= <c-w>=
" preserve yanked text when pasting in a visual selection
xnoremap <silent> p pgvy<CR>
" preserve window layout when deleting buffer
nnoremap <Leader>q :silent :bp\|bd #<CR>
" ----------------------------------------------------------
"                    Custom
" ----------------------------------------------------------
autocmd! FileType python setl nosmartindent              " Disable smartindent in python files(messing up hash commenting symbol)
autocmd BufNewFile,BufRead *.py setlocal textwidth=99    " Wrap text only in python files
autocmd BufNewFile,BufRead *.py setlocal colorcolumn=80
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif    " Hide the preview window when leaving insert mode or completion is don
autocmd InsertEnter * set nohlsearch                     " Removes highlight when in insert mode
autocmd FileType latex,tex setlocal spell " turn on spell checker for certain file types

" Disable highlighting in Insert mode for parenthesis, brackets etc..
autocmd! InsertEnter * NoMatchParen
autocmd! InsertLeave * DoMatchParen

autocmd BufWritePre * %s/\s\+$//e                   " trim whitespace on save
autocmd FileType python autocmd BufWritePre <buffer> :%s/\($\n\s*\)\+\%$//e

" jump to last position when reopening a file
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" keep same cursor position when jumping between buffers
autocmd BufLeave * let b:winview = winsaveview()
autocmd BufEnter * if(exists('b:winview')) | call winrestview(b:winview) | endif

nnoremap <C-h> <C-W>h
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-l> <C-W>l

nnoremap <silent> <A-h> :call MoveToWindow('h')<cr>
nnoremap <silent> <A-j> :call MoveToWindow('j')<cr>
nnoremap <silent> <A-k> :call MoveToWindow('k')<cr>
nnoremap <silent> <A-l> :call MoveToWindow('l')<cr>

function! MoveToWindow(key)
    let l:window_before = winnr()
    execute "wincmd " . a:key

    if winnr() == window_before
        call system('kitty @ kitten mykitten.py ' . a:key)
    endif
endfunction
