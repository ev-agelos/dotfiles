require('telescope').setup{
  defaults = {
      initial_mode='normal',
      scroll_strategy='limit'
  }
}

vim.keymap.set('n', '<f1>', '<cmd>Telescope help_tags<cr>')
vim.keymap.set('n', '<leader>fb', '<cmd>lua require("telescope.builtin").git_bcommits()<cr>')
vim.keymap.set('n', '<leader>fc', '<cmd>lua require("telescope.builtin").colorscheme()<cr>')
vim.keymap.set('n', '<leader>ff', '<cmd>lua require("telescope.builtin").find_files()<cr>')
vim.keymap.set('n', '<leader>fg', '<cmd>lua require("telescope.builtin").live_grep()<cr>')
vim.keymap.set('n', '<leader>fh', '<cmd>lua require("telescope.builtin").highlights()<cr>')
vim.keymap.set('n', '<leader>fm', '<cmd>lua require("telescope.builtin").keymaps()<cr>')
vim.keymap.set('n', '<leader>fo', '<cmd>lua require("telescope.builtin").oldfiles()<cr>')
vim.keymap.set('n', '<leader>fs', '<cmd>lua require("telescope.builtin").grep_string()<cr>')
