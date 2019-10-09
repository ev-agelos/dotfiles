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
Plug 'neoclide/coc.nvim',              {'branch': 'release'}
" ------------------------------------------------------------------ File search
Plug 'junegunn/fzf',                   { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" ------------------------------------------------------------------ History
Plug 'mbbill/undotree',                { 'on': 'UndotreeToggle'   }
" ------------------------------------------------------------------ Linters/Highlight
Plug 'Glench/Vim-Jinja2-Syntax',       { 'for': 'html' }
Plug 'jackguo380/vim-lsp-cxx-highlight'
" ------------------------------------------------------------------ Surroundings
Plug 'tpope/vim-commentary'
Plug 'machakann/vim-sandwich'
Plug 'tmsvg/pear-tree'
Plug 'alvan/vim-closetag',             { 'for': 'html' }
" ------------------------------------------------------------------ Version Control
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim',                { 'on': 'GV' }
Plug 'airblade/vim-gitgutter'
Plug 'elzr/vim-json',                  { 'for': 'json' }
" ------------------------------------------------------------------ Effects
Plug 'yuttie/comfortable-motion.vim'
Plug 'machakann/vim-highlightedyank'
" ------------------------------------------------------------------ Interface
Plug 'mhinz/vim-startify'
Plug 'ap/vim-buftabline'
Plug 'junegunn/goyo.vim',              { 'on': 'Goyo' }
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


" pear-tree
let g:pear_tree_smart_openers = 1
let g:pear_tree_smart_closers = 1
let g:pear_tree_smart_backspace = 1


" coc
" use <tab> for trigger completion and navigate to the next complete item
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()
" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <C-d> <Plug>(coc-range-select)
xmap <silent> <C-d> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>


" BufTabline
let g:buftabline_numbers=2


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
set nocursorline                 " dont highlight the line where cursor is
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
set updatetime=300
set statusline=%{gutentags#statusline('','','')}
set statusline+=%<%f
set statusline+=\ %h%{&modifiable\ &&\ &modified\ ?\ '[+]':''}%{&filetype=='help'?'':&readonly?'':''}
set statusline+=\ %{exists('*fugitive#head')\ &&\ ''!=fugitive#head()?''.fugitive#head():''}
set statusline+=%=
set statusline+=%y\ \ \ %p%%\ \ \ %l,%c
set statusline+=\ \ \ %{coc#status()}%{get(b:,'coc_current_function','')}
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
" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
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
