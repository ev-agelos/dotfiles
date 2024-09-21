-- Install lazy.nvim if not already installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)
----------------------------------------------------------------------
require('globals')
require('options') -- some plugin overwrites shopt+=a
require('mappings')
require('autocmd')
require('functions')
---------------------------------------------------------------------
plugins = {
    --Colorschemes
    { 'habamax/vim-habanight',    keys = "<leader>fc" },
    { 'iojani/silenthill.vim',    keys = "<leader>fc" },
    { "rose-pine/neovim",keys = "<leader>fc", config=function() require("rose-pine").setup({styles={italic=false}}) end},
    --light ones
    { 'habamax/vim-psionic',      keys = "<leader>fc" },
    { 'aunsira/macvim-light',     keys = "<leader>fc" },
    { 'reedes/vim-colors-pencil', keys = "<leader>fc" },
    { 'Mofiqul/adwaita.nvim',     keys = "<leader>fc" },

    { 'tpope/vim-repeat',         keys = "." },
    { 'tpope/vim-commentary',     keys = { "gc", { "gc", mode = "v" } } },
    { 'tpope/vim-unimpaired',     lazy = true },
    {
        'tpope/vim-fugitive',
        cmd = "Git",
        keys = { "gs", "glg", "gdif", "gsl" },
        config = function()
            vim.keymap.set('n', 'gs', '<cmd>Git<cr>')
            vim.keymap.set('n', 'glg', "<cmd>Git -c config.pager='diff-so-fancy | less --tabs=4 -rFX' log --color=auto --graph --branches --all --pretty=format:'%C(blue dim)%h%Creset -%C(auto)%d%C(reset) %s %C(blue dim)(%cd) %C(blue dim)<%an>%Creset' --date=short<cr>")
            vim.keymap.set('n', 'gdif', '<cmd>Git -c pager.diff="diff-so-fancy|less -RFX" diff<cr>')
            vim.keymap.set('n', 'g#', '<cmd>Git! sl<cr>')
        end,
    },
    { 'Vimjas/vim-python-pep8-indent', ft = "python" },
    { 'tpope/vim-eunuch',              cmd = { "Rename", "Remove", "Delete", "Move", "Duplicate", "Chmod", "Mkdir", "Cfind", "Clocate", "Lfind", "Llocate", "Wall", "SudoWrite", "SudoEdit" } },
    { 'nvim-lualine/lualine.nvim',     config = function() require('config.lualine') end,                                                                                                     dependencies = { 'kyazdani42/nvim-web-devicons' } },
    {
        'lewis6991/gitsigns.nvim',
        event = { "BufReadPre" },
        config = function()
            require('config.gitsigns')
        end
    },
    {
        'iamcco/markdown-preview.nvim',
        ft = { 'markdown' },
        build = "cd app && yarn install",
        init = function()
            vim.g.mkdp_filetypes = {
                "markdown" }
        end
    },
    { 'stevearc/oil.nvim',  config = function() require('config.oil') end },
    { 'mhinz/vim-startify', config = function() require('config.startify') end },
    {
        'mbbill/undotree',
        cmd = { 'UndotreeToggle' },
        config = function()
            require('config.undotree')
        end
    },
    {
        "akinsho/toggleterm.nvim",
        version = '*',
        config = function()
            require('config.toggleterm')
        end,
        keys = { "<F12>" }
    },
    { 'tmsvg/pear-tree',        config = function() require('config.pear_tree') end,                         event = "InsertEnter" },
    {
        "shortcuts/no-neck-pain.nvim",
        version = "*",
        config = function()
            require('no-neck-pain').setup({ autocmds = { enableOnVimEnter = false }, width = 130 })
        end,
        cmd = "NoNeckPain"
    },
    { 'declancm/cinnamon.nvim', config = function() require('cinnamon').setup { extra_keymaps = false } end, keys = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<PageUp>", "<PageDown>" } },
    { 'lambdalisue/suda.vim',   config = function() require('config.vim_suda') end,                          cmd = { "SudaWrite", "SudaRead" } },
    {
        'ray-x/lsp_signature.nvim',
        event = "InsertEnter",
        opts = {},
        config = function(
            _, opts)
            require('lsp_signature').setup(opts)
        end
    },
    {
        'neovim/nvim-lspconfig',
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require('config.lspconfig')
        end
    },
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        event = { "BufRead" },
        config = function()
            require('config.treesitter')
        end
    },
    {
        'williamboman/mason.nvim',
        cmd = "Mason",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = { "williamboman/mason-lspconfig.nvim" },
    },
    {
        'nvimtools/none-ls.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("null-ls").setup({
                debug = false,
                default_timeout = 10000,
                temp_dir = "/tmp",
                sources = {
                    -- mypy doesnt work: https://github.com/jose-elias-alvarez/null-ls.nvim/issues/1208
                    require('null-ls').builtins.diagnostics.mypy.with({
                        extra_args = { "--config-file", "pyproject.toml" },
                        runtime_condition = function(params)
                            return require('null-ls.utils').path.exists(params.bufname)
                        end,
                    }),
                    require("null-ls").builtins.formatting.black,
                    -- require("null-ls").builtins.diagnostics.vulture,
                    -- require('null-ls').builtins.diagnostics.pylint,
                    require("null-ls").builtins.formatting.sqlfluff.with({
                        extra_args = { "--dialect", "postgres" }, -- change to your dialect
                    }),
                    require("null-ls").builtins.diagnostics.sqlfluff.with({
                        extra_args = { "--dialect", "postgres" }, -- change to your dialect
                    })
                },
            })
        end
    },
    {
        "folke/flash.nvim",
        opts = { modes = { search = { enabled = false } } },
        keys = {
            "t", "T", "f", "F",
            { "s",     mode = { "n", "o", "x" }, function() require("flash").jump() end,              desc = "Flash" },
            { "S",     mode = { "n", "o", "x" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
            { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
            { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
            { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
        },
    },
    {
        "folke/trouble.nvim",
        dependencies = "kyazdani42/nvim-web-devicons",
        config = function()
            require('trouble').setup { mode = 'document_diagnostics', indent_lines = false, cycle_results = false }
        end,
        cmd = { "Trouble" },
        lazy = true,
    },
    {
        'RRethy/nvim-treesitter-textsubjects',
        lazy = true,
        config = function()
            require('nvim-treesitter.configs').setup({
                textsubjects = {
                    enable = true,
                    prev_selection = ',', -- (Optional) keymap to select the previous selection
                    keymaps = {
                        ['.'] = 'textsubjects-smart',
                        [';'] = 'textsubjects-container-outer',
                        ['i;'] = 'textsubjects-container-inner',
                    },
                },
            })
        end,
    },
    {
        'nvim-telescope/telescope.nvim',
        version = '0.1.3',
        config = function() require('config.telescope') end,
        dependencies = {
            'nvim-lua/plenary.nvim',
            -- 'kyazdani42/nvim-web-devicons',
            'nvim-treesitter/nvim-treesitter',
        },
        keys = "<leader>f"
    },
    {
    'Exafunction/codeium.vim',
    event = 'BufEnter',
    config = function ()
        -- Enable manually for privacy!
        vim.g.codeium_enabled = false
        -- Change '<C-g>' here to any keycode you like.
        vim.g.codeium_disable_bindings = 1
        vim.keymap.set('i', '<C-g>', function () return vim.fn['codeium#Accept']() end, { expr = true, silent = true })
        vim.keymap.set('i', '<c-;>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true, silent = true })
        vim.keymap.set('i', '<c-,>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true, silent = true })
    end
    },
    {
        'hrsh7th/nvim-cmp',
        event = "InsertEnter",
        config = function() require('config.cmp') end,
        dependencies = {
            'neovim/nvim-lspconfig',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            'onsails/lspkind-nvim', -- icons on completion menu
            { "L3MON4D3/LuaSnip", version = "v1.*" },
        }
    },
    {
        "scalameta/nvim-metals",
        ft = { "scala", "sbt", "java" },
        opts = function()
            local metals_config = require("metals").bare_config()
            metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()
            metals_config.on_attach = function(client, bufnr)
                vim.keymap.set("n", "fd", '<Cmd>lua vim.lsp.buf.definition()<CR>')
                vim.keymap.set("n", "fk", '<Cmd>lua vim.lsp.buf.hover()<CR>')
                vim.keymap.set("n", "fi", '<Cmd>lua vim.lsp.buf.implementation()<CR>')
                vim.keymap.set("n", "fr", '<Cmd>lua vim.lsp.buf.references()<CR>')
                vim.keymap.set("n", "fs", '<Cmd>lua vim.lsp.buf.signature_help()<CR>')
                vim.keymap.set("n", "ft", '<Cmd>lua vim.lsp.buf.type_definition()<CR>')
                vim.keymap.set('n', '<leader>rn', '<Cmd>lua vim.lsp.buf.rename()<CR>')
                vim.keymap.set('n', '<leader>ca', '<Cmd>lua vim.lsp.buf.code_action()<CR>')
            end
            metals_config.init_options.statusBarProvider = "on"
            return metals_config
        end,
        config = function(self, metals_config)
            local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
            vim.api.nvim_create_autocmd("FileType", {
                pattern = self.ft,
                callback = function()
                    require("metals").initialize_or_attach(metals_config)
                end,
                group = nvim_metals_group,
            })
        end
    },
}
require("lazy").setup(plugins, {}) -- leader needs to me mapped first (lazy.nvim)
vim.cmd('colorscheme rose-pine')
require('highlights')
