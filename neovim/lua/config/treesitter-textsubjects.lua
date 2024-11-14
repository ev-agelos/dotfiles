return {
    {
        'RRethy/nvim-treesitter-textsubjects',
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        keys = { "<C-v>", "x", "X" },
        config = function()
            require('nvim-treesitter.configs').setup({
                textsubjects = {
                    enable = true,
                    prev_selection = 'k', -- (Optional) keymap to select the previous selection
                    keymaps = {
                        ['j'] = 'textsubjects-smart',
                        ['o'] = 'textsubjects-container-outer',
                        ['i'] = 'textsubjects-container-inner',
                    },
                },
            })
        end,
    }
}
