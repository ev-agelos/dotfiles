return {
    {
        "folke/trouble.nvim",
        dependencies = "kyazdani42/nvim-web-devicons",
        config = function()
            require('trouble').setup {
                auto_preview = false,
                follow = false,
                auto_jump = false, -- false is the default why it jumps when 1 occurance?
                focus = true,
                -- icons = {
                --     indent = {
                --         middle = "",
                --         last = "",
                --         top = "",
                --         ws = "",
                --     },
                -- },
                modes = {
                    diagnostics = {
                        groups = {
                            { "filename", format = "{file_icon} {basename:Title} {count}" },
                        },
                    },
                },
            }
        end,
        cmd = { "Trouble" },
        keys = {
            {
                "<leader><leader>",
                "<cmd>Trouble diagnostics filter.buf=0<cr>",
                desc = "Diagnostics (Trouble)",
            },
        },
        lazy = true,
    }
}
