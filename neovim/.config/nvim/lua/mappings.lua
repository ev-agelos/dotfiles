vim.keymap.set('n', 'cp', ':let @+ = expand("%")<CR>')

vim.g.mapleader = ','
--search without escaping regex symbols
vim.keymap.set('n', '<leader>/', '/\v')
--source config file
vim.keymap.set('n', '<leader>.', ':source $MYVIMRC<CR>')
--Map to insert pdb for convenience when debugging python scripts
vim.keymap.set('n', '<leader>p', 'obreakpoint()<esc>', {silent=true})
--Split vertical/horizontally opened buffers WITH tab completion possible
vim.keymap.set('n', '<leader>b', ':vertical sb<space>')
vim.keymap.set('n', '<leader>bs', ':sb<space>')


--center screen when jumping to prev/next/before the last change
vim.keymap.set('n', 'g;', 'g;zz')
vim.keymap.set('n', 'g,', 'g,zz')
vim.keymap.set('n', "''", "''zz")
vim.keymap.set('n', 'n', ':set hlsearch<CR>nzz', {silent=true})
vim.keymap.set('n', '/', ':set hlsearch<CR>/', {silent=true})
vim.keymap.set('n', 'N', ':set hlsearch<CR>Nzz', {silent=true})
vim.keymap.set('n', '<C-o>', '<C-o>zz')
vim.keymap.set('n', '<C-i>', '<C-i>zz')
vim.keymap.set('n', 'gg', 'ggzz')

-- turn off search highlighting on ESC
vim.keymap.set('n', '<esc>', ':nohls<CR>', {silent=true})
vim.keymap.set('c', '<esc>', '<C-u><BS>:nohls<CR>', {silent=false})

--move down/up by display, but keep regular up/down
vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')
vim.keymap.set('n', 'gj', 'j')
vim.keymap.set('n', 'gk', 'k')

vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')  --Mappings for NeoVim's terminal
vim.keymap.set('n', 'Q', ':bd!<CR>')  --No need for Ex mode
vim.keymap.set('i', '<cr>', function()  --Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
    return vim.fn.pumvisible() == 1 and "<C-y>" or "<C-g>u<Cr>"
end, {expr=true})

--Don't yank to default register when changing something
vim.keymap.set('n', 'c', '"xc')
vim.keymap.set('x', 'c', '"xc')

vim.keymap.set('n', 'c*', '*``cgn')  --replace word under cursor and then with . apply downwards
vim.keymap.set('n', 'c#', '#``cgN')  --replace word under cursor and then with . apply upwards
vim.keymap.set('v', 'v', '$h')  --vv selects til end of line (not including newline)

vim.keymap.set('n', '<Leader>q', ':bdelete<CR>')

--preserve window layout when deleting buffer
vim.keymap.set('n', '<leader><BS>', '<c-^>')

vim.keymap.set('n', '<leader>=', '<c-w>=')
vim.keymap.set('x', 'p', 'pgvy<CR>', {silent=true})  --preserve yanked text when pasting in a visual selection


vim.keymap.set('n', '<space>e', '<cmd>Trouble<CR>')  -- diagnostics basically

vim.keymap.set('n', '<C-h>', '<C-W>h')
vim.keymap.set('n', '<C-j>', '<C-W>j')
vim.keymap.set('n', '<C-k>', '<C-W>k')
vim.keymap.set('n', '<C-l>', '<C-W>l')
vim.keymap.set('n', '<Up>', '<C-w>+')
vim.keymap.set('n', '<Down>', '<C-w>-')
vim.keymap.set('n', '<Left>', '<C-w>>')
vim.keymap.set('n', '<Right>', '<C-w><')
