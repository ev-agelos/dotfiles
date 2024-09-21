require("toggleterm").setup({size=30})
vim.keymap.set('n', '<F12>', ':ToggleTerm<CR>', {silent=true})
vim.keymap.set('t', '<F12>', [[<C-\><C-n>:ToggleTerm<CR>]], {silent=true})

-- local Terminal  = require('toggleterm.terminal').Terminal
-- local gitlg = Terminal:new({cmd="git lg"})
-- local gitl = Terminal:new({cmd="git l"})
-- local gitstatus = Terminal:new({cmd="git -c color.status=always status | less"})
-- function _gitlg_toggle() gitlg:toggle() end
-- function _gitl_toggle() gitl:toggle() end
-- function _gitstatus_toggle() gitstatus:toggle() end
-- vim.keymap.set('n', 'glg', '<cmd>lua _gitlg_toggle()<CR>', {noremap=true, silent=true})
-- vim.keymap.set('n', 'gl', '<cmd>lua _gitl_toggle()<CR>', {noremap=true, silent=true})
-- vim.keymap.set('n', 'gs', '<cmd>lua _gitstatus_toggle()<CR>', {noremap=true, silent=true})
