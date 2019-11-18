let g:python_host_prog = '/usr/bin/python2'
let g:python3_host_prog = '/usr/bin/python3'
set path+=**

call plug#begin('~/.config/nvim/plugged')
" ------------------------------------------------------------------ Generic
Plug 'liuchengxu/vista.vim',              { 'on': 'Vista!!' }
Plug 'ludovicchabant/vim-gutentags'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'justinmk/vim-dirvish'
Plug 'haya14busa/incsearch.vim'
Plug 'google/vim-searchindex'
Plug 'skywind3000/asyncrun.vim'
" ------------------------------------------------------------------ Unix shell commands
Plug 'tpope/vim-eunuch'
Plug 'lambdalisue/suda.vim'
" ------------------------------------------------------------------ Completion
Plug 'neoclide/coc.nvim',              {'branch': 'release'}
" ------------------------------------------------------------------ File search
" Note: zsh handles the base fzf.vim
Plug '~/.config/zplugin/snippets/fzf' | Plug 'junegunn/fzf.vim'
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
" ------------------------------------------------------------------ Effects / Interface
Plug 'psliwka/vim-smoothie'
Plug 'machakann/vim-highlightedyank'
Plug 'inside/vim-search-pulse'
Plug 'mhinz/vim-startify'
Plug 'ap/vim-buftabline'
Plug 'junegunn/goyo.vim',              { 'on': 'Goyo' }
" ------------------------------------------------------------------ Colorschemes
Plug 'ThomasMarcel/vim-colors-plain'
Plug 'aunsira/macvim-light'
Plug 'ev-agelos/vim-deep-space'
Plug 'ev-agelos/blaquemagick.vim'
Plug 'tlhr/anderson.vim'
Plug 'doums/darcula'
Plug 'voldikss/vim-floaterm'
Plug 'whatyouhide/vim-gotham'
call plug#end()

" ----------------------------------------------------------
"                    Colorschemes
" ----------------------------------------------------------
set termguicolors " use 24-bit color
set background=dark
colorscheme gotham

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

" vim-search-pulse
" make it work with incsearch
let g:vim_search_pulse_disable_auto_mappings = 1
" Next or previous match is followed by a Pulse
map n <Plug>(incsearch-nohl-n)<Plug>Pulse
map N <Plug>(incsearch-nohl-N)<Plug>Pulse
map * <Plug>(incsearch-nohl-*)<Plug>Pulse
map # <Plug>(incsearch-nohl-#)<Plug>Pulse
map g* <Plug>(incsearch-nohl-g*)<Plug>Pulse
map g# <Plug>(incsearch-nohl-g#)<Plug>Pulse
" Pulses the first match after hitting the enter keyan
autocmd! User IncSearchExecute
autocmd User IncSearchExecute :call search_pulse#Pulse()

" floaterm
noremap  <silent> <F12>           :FloatermToggle<CR>i
noremap! <silent> <F12>           <Esc>:FloatermToggle<CR>i
tnoremap <silent> <F12>           <C-\><C-n>:FloatermToggle<CR>
let g:floaterm_winblend=10
let g:floaterm_position='center'
let g:floaterm_height=&lines


" vista
let g:vista#renderer#enable_icon = 1
let g:vista_default_executive = 'coc'
let g:vista_fzf_preview = ['right:50%']
nmap <F9> :Vista<CR>


"
let g:gitgutter_sign_added = '▎'
let g:gitgutter_sign_modified = '▎'
let g:gitgutter_sign_removed = '▶'
let g:gitgutter_sign_modified_removed = '▎'


" suda
command! -nargs=1 SudoRead  edit  suda://<args>
command! -nargs=1 SudoWrite write suda://<args>


" Gutentags
let g:gutentags_cache_dir='~/.cache/gutentags'


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

au CursorHoldI * sil call CocActionAsync('showSignatureHelp')
" show chunk diff at current position
nmap gs <Plug>(coc-git-chunkinfo)

function! s:EditAlternate()
    let l:alter = CocRequest('clangd', 'textDocument/switchSourceHeader', {'uri': 'file://'.expand("%:p")})
    " remove file:/// from response
    let l:alter = substitute(l:alter, "file://", "", "")
    execute 'edit ' . l:alter
endfunction
autocmd FileType cpp nmap <A-o> :call <SID>EditAlternate()<CR>


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
  \   'rg --column --line-number --no-heading --fixed-strings --smart-case --hidden --follow --color=always --no-messages --context=0 '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview('right:60%'),
  \   <bang>0)
" MRU with preview
command! -bang -nargs=* MRU call fzf#vim#history(fzf#vim#with_preview())


" ---------------------------------------------------------
"                    Settings
" ---------------------------------------------------------
" use :help '<setting>' for details
set foldmethod=indent
set foldlevel=99
set splitright
set splitbelow
set mouse=a
set wildmode=full
set wildignorecase
" Do not blink in normal mode, Use pipe shape in insert mode
set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor
set clipboard+=unnamedplus
set nocursorline
set nostartofline
set virtualedit=block
set scrolloff=3
set sidescrolloff=5
set sidescroll=1
set backspace=2
set showmatch
set nowrap
set formatoptions+=t
set linebreak
set smartindent
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set shiftround
set inccommand=split
set nojoinspaces
set noswapfile
set hidden
set noautoread
set noequalalways
set showcmd
set report=0
set shortmess+=a
set ruler
set wrapscan
set ignorecase
set smartcase
set wildignore+=*.o,*.obj,.git,*.pyc
set wildignore+=eggs/**
set wildignore+=*.egg-info/**
set showmode
set undofile
set undodir=~/.config/nvim/undo
set undolevels=1000
set updatetime=300
set statusline=%{gutentags#statusline('','','')}
set statusline+=%<\ [%n]\ %<%f
set statusline+=\ %h%{&modifiable\ &&\ &modified\ ?\ '[+]':''}%{&filetype=='help'?'':&readonly?'':''}
set statusline+=%=%{exists('*fugitive#head')\ &&\ ''!=fugitive#head()?''.fugitive#head():''}
set statusline+=%=
set statusline+=%y\ \ \ %l/%L\ -\ %c
" set statusline+=\ \ \ %{coc#status()}%{get(b:,'coc_current_function','')}
"       \              [ 'fileencoding' ],
"       \ 'inactive': {
"       \   'left': [ [ 'absolutepath'] ],
"       \ 'component_expand': {
"       \   'dirpath': 'LightlineHomeDirPath',
set laststatus=2

" ----------------------------------------------------------
"                    Mappings
" ----------------------------------------------------------
" center screen when jumping to prev/next/before the last change
nnoremap g; g;zz
nnoremap g, g,zz
nnoremap '' ''zz
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
nnoremap <Leader>d :silent :bp\|bd #<CR>
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

