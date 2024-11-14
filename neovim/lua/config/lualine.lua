return {
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'kyazdani42/nvim-web-devicons' },
        config = function()
            require('lualine').setup {
                options = {
                    icons_enabled = true,
                    theme = 'modus-vivendi',
                    component_separators = { left = '', right = '' },
                    section_separators = { left = '', right = '' },
                    disabled_filetypes = {
                        statusline = {},
                        winbar = {},
                    },
                    ignore_focus = {},
                    always_divide_middle = true,
                    globalstatus = true,
                    refresh = {
                        statusline = 1000,
                        tabline = 1000,
                        winbar = 1000,
                    }
                },
                sections = {
                    lualine_a = {
                    },
                    lualine_b = {
                    },
                    lualine_c = {
                        {
                            'buffers',
                            component_separators = { left = '', right = '' },
                            section_separators = { left = '', right = '' },
                            show_modified_status = false,
                            icons_enabled = false,
                            max_length = vim.o.columns,
                            symbols = {
                                modified = '', -- Text to show when the buffer is modified
                                alternate_file = '', -- Text to show to identify the alternate file
                                directory = '', -- Text to show when the buffer is a directory
                            },
                        },
                        {
                            'progress',
                            component_separators = { left = '', right = '' },
                            padding = { left = 10 },
                        },
                    },
                    lualine_x = {
                        { 'g:metals_status', color = { gui = "italic" }, component_separators = { left = '', right = '' } },
                        {
                            function()
                                if vim.fn.exists("*codeium#GetStatusString") == 1 then
                                    return 'AI:' .. vim.api.nvim_call_function("codeium#GetStatusString", {})
                                end
                                return 'AI: OFF'
                            end,
                            component_separators = { left = '', right = '' },
                            section_separators = { left = '', right = '' },
                            color = function(_)
                                if vim.fn.exists("*codeium#GetStatusString") == 1 then
                                    return {
                                        fg = vim.api.nvim_call_function("codeium#GetStatusString", {}) == 'OFF' and
                                            '#aa3355' or '#33aa88'
                                    }
                                end
                                return { fg = '#aa3355' }
                            end,
                        },
                    },
                    lualine_y = {},
                    lualine_z = { 'branch' }
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = { 'filename' },
                    lualine_x = { 'location' },
                    lualine_y = {},
                    lualine_z = {}
                },
                tabline = {},
                winbar = {
                    lualine_a = { 'searchcount', 'selectioncount' },
                    lualine_b = {
                        { 'filename', file_status = false, path = 4 },
                    },
                    lualine_c = {
                        {
                            'diagnostics',
                            component_separators = { left = '', right = '' },
                        },
                        {
                            'location',
                            padding = 10,
                            color = function()
                                local hl = vim.api.nvim_get_hl(0, { name = "lualine_a_normal" })
                                return { fg = string.format("#%06x", hl.bg) }
                            end
                        },
                    },
                    lualine_x = {
                        { 'encoding',   component_separators = { left = '', right = '' } },
                        { 'fileformat', component_separators = { left = '', right = '' } },
                        { 'filetype',   component_separators = { left = '', right = '' } },
                    },
                    lualine_y = {},
                    lualine_z = {}
                },
                inactive_winbar = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = { 'filename' },
                    lualine_x = {},
                    lualine_y = {},
                    lualine_z = {}
                },
                extensions = {}
            }
            ------------------------------------------------------------------------------------------------------------
            local colors = {
                red = '#ca1243',
                grey = '#a0a1a7',
                black = '#383a42',
                white = '#f3f3f3',
                light_green = '#83a598',
                orange = '#fe8019',
                green = '#8ec07c',
            }

            local theme = {
                normal = {
                    a = { fg = colors.white, bg = colors.black },
                    b = { fg = colors.white, bg = colors.grey },
                    c = { fg = colors.black, bg = colors.white },
                    z = { fg = colors.white, bg = colors.black },
                },
                insert = { a = { fg = colors.black, bg = colors.light_green } },
                visual = { a = { fg = colors.black, bg = colors.orange } },
                replace = { a = { fg = colors.black, bg = colors.green } },
            }

            local empty = require('lualine.component'):extend()
            function empty:draw(default_highlight)
                self.status = ''
                self.applied_separator = ''
                self:apply_highlights(default_highlight)
                self:apply_section_separators()
                return self.status
            end

            -- Put proper separators and gaps between components in sections
            local function process_sections(sections)
                for name, section in pairs(sections) do
                    local left = name:sub(9, 10) < 'x'
                    for pos = 1, name ~= 'lualine_z' and #section or #section - 1 do
                        table.insert(section, pos * 2, { empty, color = { fg = colors.white, bg = colors.white } })
                    end
                    for id, comp in ipairs(section) do
                        if type(comp) ~= 'table' then
                            comp = { comp }
                            section[id] = comp
                        end
                        comp.separator = left and { right = '' } or { left = '' }
                    end
                end
                return sections
            end

            local function search_result()
                if vim.v.hlsearch == 0 then
                    return ''
                end
                local last_search = vim.fn.getreg('/')
                if not last_search or last_search == '' then
                    return ''
                end
                local searchcount = vim.fn.searchcount { maxcount = 9999 }
                return last_search .. '(' .. searchcount.current .. '/' .. searchcount.total .. ')'
            end

            local function modified()
                if vim.bo.modified then
                    return '+'
                elseif vim.bo.modifiable == false or vim.bo.readonly == true then
                    return '-'
                end
                return ''
            end

            -- require('lualine').setup {
            --   options = {
            --     theme = theme,
            --     component_separators = '',
            --     section_separators = { left = '', right = '' },
            --   },
            --   sections = process_sections {
            --     lualine_a = { 'mode' },
            --     lualine_b = {
            --       'branch',
            --       -- 'diff',
            --       {
            --         'diagnostics',
            --         source = { 'nvim' },
            --         sections = { 'error' },
            --         diagnostics_color = { error = { bg = colors.red, fg = colors.white } },
            --       },
            --       {
            --         'diagnostics',
            --         source = { 'nvim' },
            --         sections = { 'warn' },
            --         diagnostics_color = { warn = { bg = colors.orange, fg = colors.white } },
            --       },
            --       { 'filename', file_status = false, path = 1 },
            --       { modified, color = { bg = colors.red } },
            --       {
            --         '%w',
            --         cond = function()
            --           return vim.wo.previewwindow
            --         end,
            --       },
            --       {
            --         '%r',
            --         cond = function()
            --           return vim.bo.readonly
            --         end,
            --       },
            --       {
            --         '%q',
            --         cond = function()
            --           return vim.bo.buftype == 'quickfix'
            --         end,
            --       },
            --     },
            --     lualine_c = {},
            --     lualine_x = {},
            --     lualine_y = { search_result, 'filetype' },
            --     lualine_z = { '%l:%c', '%p%%/%L' },
            --   },
            --   inactive_sections = {
            --     lualine_c = { '%f %y %m' },
            --     lualine_x = {},
            --   },
            -- }
        end,
    }
}
