return {
    {
        'echasnovski/mini.surround',
        version = '*',
        keys = { "m" },
        config = function()
            local mini = require('mini.surround')
            mini.setup({
                n_lines = 70,
                mappings = {
                    add = 'ms',       -- Add surrounding in Normal and Visual modes
                    delete = 'md',    -- Delete surrounding
                    replace = 'mr',   -- Replace surrounding
                    find = 'm]',      -- Find surrounding (to the right)
                    find_left = 'm[', -- Find surrounding (to the left)
                    highlight = 'mh', -- Highlight surrounding
                    -- update_n_lines = 'sn', -- Update `n_lines`
                    -- Add this only if you don't want to use extended mappings
                    suffix_last = 'l',
                    suffix_next = 'n',
                },
                search_method = 'cover_or_next',
            })
            vim.keymap.set("n", "ms", "viwms", { remap = true })
            vim.keymap.set("n", "mm", "%")
        end
    }
}
