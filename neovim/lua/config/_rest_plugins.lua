return {
    { 'tpope/vim-repeat',        keys = "." },
    { 'williamboman/mason.nvim', cmd = "Mason", event = { "BufReadPre", "BufNewFile" }, dependencies = { "williamboman/mason-lspconfig.nvim" } },
    {
        'mbbill/undotree',
        cmd = { 'UndotreeToggle' },
        config = function()
            vim.keymap.set('n',
                '<leader>u', ':UndotreeToggle<CR>')
        end
    },
    {
        'OXY2DEV/markview.nvim',
        ft = { 'markdown' },
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons"
        }
    },
    {
        "shortcuts/no-neck-pain.nvim",
        version = "*",
        config = function()
            require('no-neck-pain').setup({ autocmds = { enableOnVimEnter = false }, width = 130 })
        end,
        cmd = "NoNeckPain"
    },
    {
        'declancm/cinnamon.nvim',
        version = '*',
        config = function()
            require('cinnamon').setup {
                keymaps = {
                    basic = true,
                    extra = false,
                },
                options = {
                    mode = "window",
                }
            }
        end,
        keys = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<PageUp>", "<PageDown>" }
    },
    {
        "folke/flash.nvim",
        opts = { modes = { search = { enabled = false } } },
        keys = {
            "t", "T", "f", "F",
            { "gw",    mode = { "n", "o", "x" }, function() require("flash").jump() end,              desc = "Flash" },
            { "S",     mode = { "n", "o", "x" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
            { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
            { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
            { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
        },
    },
    {
        'lambdalisue/suda.vim',
        config = function()
            vim.api.nvim_create_user_command(
                "SudoRead",
                "edit suda://<args>",
                { bang = true, nargs = 1 }
            )

            vim.api.nvim_create_user_command(
                "SudoWrite",
                "write suda://<args>",
                { bang = true, nargs = 1 }
            )
        end,
        cmd = { "SudaWrite", "SudaRead" }
    },
    {
        "akinsho/toggleterm.nvim",
        version = '*',
        config = function()
            require("toggleterm").setup({ size = 30 })
            vim.keymap.set('n', '<F12>', ':ToggleTerm<CR>', { silent = true })
            vim.keymap.set('t', '<F12>', [[<C-\><C-n>:ToggleTerm<CR>]], { silent = true })

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
        end,
        keys = { "<F12>" }
    },
    {
        'tpope/vim-fugitive',
        cmd = "Git",
        keys = { "<leader>g" },
        config = function()
            vim.keymap.set('n', '<leader>gs', '<cmd>Git<cr>', { desc = "status" })
            vim.keymap.set(
                'n',
                '<leader>glg',
                "<cmd>Git -c config.pager='diff-so-fancy | less --tabs=4 -rFX' log --color=auto --graph --branches --all --pretty=format:'%C(blue dim)%h%Creset -%C(auto)%d%C(reset) %s %C(blue dim)(%cd) %C(blue dim)<%an>%Creset' --date=short<cr>",
                { desc = "graph" }
            )
            vim.keymap.set(
                'n',
                '<leader>gdif', '<cmd>Git -c pager.diff="diff-so-fancy|less -RFX" diff<cr>',
                { desc = "dif" }
            )
            vim.keymap.set('n', '<leader>g#', '<cmd>Git! sl<cr>', { desc = "stashes" })
        end,
    },
    {
        'stevearc/oil.nvim',
        dependencies = { "refractalize/oil-git-status.nvim" },
        -- cant lazy load it cause i loose opening a directory with nvim or jump from startify to a directory
        config = function()
            require('oil').setup({
                win_options = { signcolumn = "yes:1" }, -- for oil-git-status
                columns = { "icon" },
                view_options = {
                    show_hidden = true
                },
                keymaps = {
                    ["`"] = false,     -- conflicts with my mapping(telescope)
                    ["<C-h>"] = false, -- conflicts with jumping windows
                    ["<C-l>"] = false, -- conflicts with jumping windows
                }
            })
            vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
            require("oil-git-status").setup({ show_ignored = false })

            -- My custom mapping to vsplit buffers or open Oil
            vim.keymap.set("ca", "vs", function()
                    local total_windows = vim.fn.winnr('$')
                    local total_buffers = vim.fn.len(vim.fn.getbufinfo({ buflisted = 1 }))
                    if total_windows < total_buffers then
                        vim.cmd("vs|bnext")
                    else
                        vim.cmd("vs|Oil")
                    end
                end,
                { desc = "vsplit buffer if not in a window otherwise open Oil" }
            )
        end
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
            preset = "helix",
        },
        keys = {
            {
                "<leader>?",
                function()
                    require("which-key").show({ global = false })
                end,
                desc = "Buffer Local Keymaps (which-key)",
            },
        },
    },
    {
        "meznaric/key-analyzer.nvim",
        config = function()
            require("key-analyzer").setup({
                -- Name of the command to use for the plugin
                command_name = "KeyAnalyzer", -- or nil to disable the command

                -- Customize the highlight groups
                highlights = {
                    bracket_used = "KeyAnalyzerBracketUsed",
                    letter_used = "KeyAnalyzerLetterUsed",
                    bracket_unused = "KeyAnalyzerBracketUnused",
                    letter_unused = "KeyAnalyzerLetterUnused",
                    promo_highlight = "KeyAnalyzerPromo",

                    -- Set to false if you want to define highlights manually
                    define_default_highlights = true,
                },
            })
        end
    },
}
