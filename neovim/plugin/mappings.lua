-- copy the absolute file path to register
-- vim copies only the filename to % so copy the whole thing
vim.keymap.set('n', 'yp', ':let @+ = expand("%")<CR>')

--search without escaping regex symbols
vim.keymap.set('n', '/', ':set hlsearch<CR>/\\v', { silent = true })
--Map to insert pdb for convenience when debugging python scripts
vim.keymap.set('n', '<leader>p', 'obreakpoint()\n...<esc>', { silent = true })


--center screen when jumping to prev/next/before the last change
vim.keymap.set('n', 'gg', 'ggzz') -- for when using 34gg to go to 34 line
vim.keymap.set('n', "''", "''zz")
vim.keymap.set('n', 'n', ':set hlsearch<CR>nzz', { silent = true })
vim.keymap.set('n', 'N', ':set hlsearch<CR>Nzz', { silent = true })
vim.keymap.set('n', '<C-o>', '<C-o>zz')
vim.keymap.set('n', '<C-i>', '<C-i>zz')

-- turn off search highlighting on ESC
-- vim.keymap.set('n', '<esc>', ':nohls<CR>', {silent=true})
-- this conflicts when lsp renaming and cancelling by hitting esc
-- vim.keymap.set('c', '<esc>', '<C-u><BS>:nohls<CR>', {silent=false})

--move down/up by display, but keep regular up/down
vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')

vim.keymap.set('t', '<Esc>', '<C-\\><C-n>') --Mappings for NeoVim's terminal
vim.keymap.set('n', 'Q', ':bd!<CR>')        --No need for Ex mode
-- vim.keymap.set('i', '<cr>', function()  --Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
--     return vim.fn.pumvisible() == 1 and "<C-y>" or "<C-g>u<Cr>"
-- end, {expr=true})

--Don't yank to default register when changing something
vim.keymap.set('n', 'c', '"xc')
vim.keymap.set('x', 'c', '"xc')

-- vim.keymap.set('n', 'c*', '*``cgn')  --replace word under cursor and then with . apply downwards
-- vim.keymap.set('n', 'c#', '#``cgN')  --replace word under cursor and then with . apply upwards
vim.keymap.set('v', 'v', '$h', { desc = "selects til end of line (not including newline)" })

vim.keymap.set('n', '<Leader>q', ':bdelete<CR>')

--preserve window layout when deleting buffer
-- vim.keymap.set('n', '<leader><BS>', '<c-^>')

vim.keymap.set('n', '<leader>=', '<c-w>=')
vim.keymap.set('x', 'p', 'pgvy<CR>', { silent = true }) --preserve yanked text when pasting in a visual selection
vim.keymap.set('n', 'P', 'gP==')                        --cursor end of paste
vim.keymap.set('n', 'p', 'gp==')                        --cursor end of paste

vim.keymap.set('n', '<C-h>', '<C-W>h')
vim.keymap.set('n', '<C-j>', '<C-W>j')
vim.keymap.set('n', '<C-k>', '<C-W>k')
vim.keymap.set('n', '<C-l>', '<C-W>l')
vim.keymap.set('n', '<Up>', '<C-w>+')
vim.keymap.set('n', '<Down>', '<C-w>-')
vim.keymap.set('n', '<Left>', '<C-w>>')
vim.keymap.set('n', '<Right>', '<C-w><')
