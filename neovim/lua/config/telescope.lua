return {
    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        keys = "<leader>",
        config = function()
            require('telescope').setup {
                defaults = {
                    initial_mode = 'normal',
                    scroll_strategy = 'limit'
                }
            }
            -- load extension to navigate buffer back in git history
            require("telescope").load_extension("git_file_history")

            vim.keymap.set('n', '<leader>t', '<cmd>Telescope builtin theme=dropdown layout_config={width=0.5}<cr>')

            vim.keymap.set('n', '<leader>f', '<cmd>lua require("telescope.builtin").find_files()<cr>')
            vim.keymap.set('n', '<leader>F', '<cmd>lua require("telescope.builtin").oldfiles()<cr>')
            vim.keymap.set('n', '<leader>gf', '<cmd>Telescope git_file_history<cr>')
            vim.keymap.set('n', '<leader>b', '<cmd>lua require("telescope.builtin").buffers()<cr>')
            vim.keymap.set('n', '<leader>c', '<cmd>lua require("telescope.builtin").colorscheme()<cr>')
            vim.keymap.set('n', '<leader>/', '<cmd>lua require("telescope.builtin").live_grep()<cr>')
            -- vim.keymap.set('n', '...', '<cmd>lua require("telescope.builtin").grep_string()<cr>')
            vim.keymap.set('n', '<leader>m', '<cmd>lua require("telescope.builtin").keymaps()<cr>')

            -- vim.keymap.set('n', ',"', '<cmd>lua require("telescope.builtin").registers()<cr>')
            -- vim.keymap.set('n', '`@', '<cmd>lua require("telescope.builtin").registers()<cr>')
            -- vim.keymap.set('i', '<C-r>', '<cmd>lua require("telescope.builtin").registers()<cr>')
        end,
        dependencies = {
            'nvim-lua/plenary.nvim',
            -- 'kyazdani42/nvim-web-devicons',
            'nvim-treesitter/nvim-treesitter',
            {
                "isak102/telescope-git-file-history.nvim",
                dependencies = {
                    "nvim-lua/plenary.nvim",
                    "tpope/vim-fugitive"
                }
            }
        },
    }
}
