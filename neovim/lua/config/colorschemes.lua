return {
    --Colorschemes
    { 'habamax/vim-habanight', keys = "<leader>fc" },
    { 'iojani/silenthill.vim', keys = "<leader>fc" },
    {
        "rose-pine/neovim",
        priority = 1000,
        lazy = false,
        keys = "<leader>fc",
        config = function()
            require("rose-pine").setup({ styles = { italic = false } })
            vim.cmd('colorscheme rose-pine')
        end
    },
    --light ones
    { 'habamax/vim-psionic',      keys = "<leader>fc" },
    { 'aunsira/macvim-light',     keys = "<leader>fc" },
    { 'reedes/vim-colors-pencil', keys = "<leader>fc" },
    { 'Mofiqul/adwaita.nvim',     keys = "<leader>fc" },
}
