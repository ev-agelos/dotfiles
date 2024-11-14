return {
    {
        'hrsh7th/nvim-cmp',
        event = "InsertEnter",
        dependencies = {
            'neovim/nvim-lspconfig',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            'onsails/lspkind-nvim', -- icons on completion menu
            'saadparwaiz1/cmp_luasnip',
            "L3MON4D3/LuaSnip",
        },
        config = function()
            -- local has_words_before = function()
            --   local line, col = unpack(vim.api.nvim_win_get_cursor(0))
            --   return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
            -- end

            local luasnip = require("luasnip")
            local cmp = require('cmp')
            local lspkind = require('lspkind')
            require("luasnip.loaders.from_vscode").lazy_load()

            cmp.setup({
                snippet = {
                    -- REQUIRED - you must specify a snippet engine
                    expand = function(args)
                        luasnip.lsp_expand(args.body) -- For `luasnip` users.
                    end,
                },

                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                performance = {
                    max_view_entries = 30
                },
                mapping = cmp.mapping.preset.insert({
                    -- ['<C-d>'] = cmp.mapping.scroll_docs(-4),
                    -- ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-c>'] = cmp.mapping.abort(),

                    ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
                    ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
                    -- ["<C-y>"] = cmp.mapping(
                    --     cmp.mapping.confirm {
                    --         behavior = cmp.ConfirmBehavior.Insert,
                    --         select = true,
                    --     },
                    --     { "i", "c" }
                    -- ),
                    ["<CR>"] = cmp.mapping({
                        i = function(fallback)
                            if cmp.visible() and cmp.get_active_entry() then
                                cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
                            else
                                fallback()
                            end
                        end,
                        s = cmp.mapping.confirm({ select = true }),
                        -- c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
                        c = function(fallback)
                            if cmp.visible() and cmp.get_active_entry() then
                                cmp.confirm()
                                vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<CR>", true, true, true), 'n', true)
                            else
                                fallback()
                            end
                        end,
                    }),
                    ["<Tab>"] = vim.NIL,
                    ["<S-Tab>"] = vim.NIL,
                }),

                sources = cmp.config.sources({
                    { name = 'luasnip' }, -- For luasnip users.
                    { name = 'nvim_lsp' },
                    { name = 'path' },
                    { name = 'buffer' },
                }),

                formatting = {
                    -- Show the server instead of [LSP]
                    format = function(entry, vim_item)
                        -- Set LSP source name (like pylsp, pyright, etc.)
                        local source_name = entry.source.name
                        if source_name == "nvim_lsp" then
                            source_name = entry.source.source.client.name
                        end

                        -- Add LSP kind icons using lspkind (optional)
                        vim_item.kind = lspkind.symbolic(vim_item.kind, { mode = 'symbol_text' })

                        -- Customize the menu to show the actual LSP server name
                        vim_item.menu = ({
                            nvim_lsp = "[" .. source_name .. "]",
                            luasnip = "[snip]",
                            buffer = "[buf]",
                            path = "[path]",
                            spell = "[spell]",
                            calc = "[calc]",
                            -- Add more sources if needed
                        })[entry.source.name] or "[" .. source_name .. "]"

                        return vim_item
                    end
                },

            })


            cmp.setup.cmdline({ '/', '?' }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = 'buffer' }
                }
            })

            --Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources(
                    { { name = 'cmdline', option = { treat_trailing_slash = false }, max_item_count = 20 } },
                    { { name = 'path', option = { trailing_slash = true }, max_item_count = 20 } }
                )
            })

            -- Completion colors
            -- grey
            vim.cmd('highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080')
            -- blue
            vim.cmd('highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6')
            vim.cmd('highlight! CmpItemAbbrMatchFuzzy guibg=NONE guifg=#569CD6')
            -- light blue
            vim.cmd('highlight! CmpItemKindVariable guibg=NONE guifg=#9CDCFE')
            vim.cmd('highlight! CmpItemKindInterface guibg=NONE guifg=#9CDCFE')
            vim.cmd('highlight! CmpItemKindText guibg=NONE guifg=#9CDCFE')
            -- pink
            vim.cmd('highlight! CmpItemKindFunction guibg=NONE guifg=#C586C0')
            vim.cmd('highlight! CmpItemKindMethod guibg=NONE guifg=#C586C0')
            -- front
            vim.cmd('highlight! CmpItemKindKeyword guibg=NONE guifg=#D4D4D4')
            vim.cmd('highlight! CmpItemKindProperty guibg=NONE guifg=#D4D4D4')
            vim.cmd('highlight! CmpItemKindUnit guibg=NONE guifg=#D4D4D4')
        end,
    }
}
