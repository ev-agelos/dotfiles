return {
    {
        'lewis6991/gitsigns.nvim',
        event = { "BufReadPre" },
        config = function()
            require('gitsigns').setup {
                on_attach               = function(bufnr)
                    local gs = package.loaded.gitsigns

                    local function map(mode, l, r, opts)
                        opts = opts or {}
                        opts.buffer = bufnr
                        vim.keymap.set(mode, l, r, opts)
                    end

                    -- Navigation
                    map('n', '<leader>g]', function()
                        if vim.wo.diff then return 'g]' end
                        vim.schedule(function() gs.next_hunk() end)
                        return '<Ignore>'
                    end, { expr = true })

                    map('n', '<leader>g[', function()
                        if vim.wo.diff then return 'g[' end
                        vim.schedule(function() gs.prev_hunk() end)
                        return '<Ignore>'
                    end, { expr = true })

                    -- Actions
                    map('n', '<leader>ga', gs.stage_hunk, { desc = "add hunk" })
                    map('n', '<leader>gr', function() gs.reset_hunk { vim.fn.line('.'), vim.fn.line('.') } end, { desc = "reset hunk" })
                    map('v', '<leader>ga', function() gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end, { desc = "add hunk" })
                    map('v', '<leader>gr', function() gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end, { desc = "reset hunk" })
                    map('n', '<leader>gA', gs.stage_buffer, { desc = "add buffer" })
                    map('n', '<leader>gu', gs.undo_stage_hunk, { desc = "undo add" })
                    map('n', '<leader>gR', gs.reset_buffer, { desc = "reset buffer" })
                    map('n', '<leader>gp', gs.preview_hunk, { desc = "preview" })
                    map('n', '<leader>gB', function() gs.blame_line { full = true } end, { desc = "full blame" })
                    map('n', '<leader>gb', gs.toggle_current_line_blame, { desc = "blame" })
                    map('n', '<leader>gd', gs.diffthis, { desc = "diff" })
                    map('n', '<leader>gD', function() gs.diffthis('~') end, { desc = "diff" })
                    map('n', '<leader>gt', gs.toggle_deleted, { desc = "toggle deleted" })

                    -- Text object
                    map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = "select hunk" })
                end,

                signs                   = {
                    add          = { text = '▎' },
                    change       = { text = '▎' },
                    delete       = { text = '➤' },
                    topdelete    = { text = '➤' },
                    changedelete = { text = '➤' },
                },
                signcolumn              = true,  -- Toggle with `:Gitsigns toggle_signs`
                numhl                   = false, -- Toggle with `:Gitsigns toggle_numhl`
                linehl                  = false, -- Toggle with `:Gitsigns toggle_linehl`
                word_diff               = false, -- Toggle with `:Gitsigns toggle_word_diff`

                watch_gitdir            = {
                    interval = 1000,
                    follow_files = true
                },
                attach_to_untracked     = true,
                current_line_blame      = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
                current_line_blame_opts = {
                    virt_text = true,
                    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
                    delay = 0,
                    ignore_whitespace = false,
                },
                sign_priority           = 6,
                update_debounce         = 100,
                status_formatter        = nil, -- Use default
                max_file_length         = 40000,
                preview_config          = {
                    -- Options passed to nvim_open_win
                    border = 'single',
                    style = 'minimal',
                    relative = 'cursor',
                    row = 0,
                    col = 1
                },
            }
            vim.api.nvim_set_hl(0, 'GitSignsAdd', { link = 'GitSignsAdd' })
            vim.api.nvim_set_hl(0, 'GitSignsAddLn', { link = 'GitSignsAddLn' })
            vim.api.nvim_set_hl(0, 'GitSignsAddNr', { link = 'GitSignsAddNr' })
            vim.api.nvim_set_hl(0, 'GitSignsChange', { link = 'GitSignsChange' })
            vim.api.nvim_set_hl(0, 'GitSignsChangeLn', { link = 'GitSignsChangeLn' })
            vim.api.nvim_set_hl(0, 'GitSignsChangeNr', { link = 'GitSignsChangeNr' })
            vim.api.nvim_set_hl(0, 'GitSignsChangedelete', { link = 'GitSignsChange' })
            vim.api.nvim_set_hl(0, 'GitSignsChangedeleteLn', { link = 'GitSignsChangeLn' })
            vim.api.nvim_set_hl(0, 'GitSignsChangedeleteNr', { link = 'GitSignsChangeNr' })
            vim.api.nvim_set_hl(0, 'GitSignsDelete', { link = 'GitSignsDelete' })
            vim.api.nvim_set_hl(0, 'GitSignsDeleteLn', { link = 'GitSignsDeleteLn' })
            vim.api.nvim_set_hl(0, 'GitSignsDeleteNr', { link = 'GitSignsDeleteNr' })
            vim.api.nvim_set_hl(0, 'GitSignsTopdelete', { link = 'GitSignsDelete' })
            vim.api.nvim_set_hl(0, 'GitSignsTopdeleteLn', { link = 'GitSignsDeleteLn' })
            vim.api.nvim_set_hl(0, 'GitSignsTopdeleteNr', { link = 'GitSignsDeleteNr' })
        end
    }
}
