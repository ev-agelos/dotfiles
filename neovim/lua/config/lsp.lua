-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    -- dont continue the new line with comment
    vim.opt.formatoptions:remove("o")

    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    -- Enable completion triggered by <c-x><c-o>
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    local opts = { noremap = true, silent = false }

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', '<leader>k', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    -- buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    -- buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    -- buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    buf_set_keymap('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<leader>r', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<leader>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>Trouble lsp_references<CR>', opts)
    -- buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
    -- buf_set_keymap('n', '[s', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    -- buf_set_keymap('n', ']s', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
    -- buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
    vim.fn.sign_define("DiagnosticSignError", { text = "✗", texthl = "DiagnosticSignError" })
    vim.fn.sign_define("DiagnosticSignWarn", { text = "!", texthl = "DiagnosticSignWarn" })
    vim.fn.sign_define("DiagnosticSignInformation", { text = "", texthl = "DiagnosticSignInfo" })
    vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })

    -- highlight under cursor
    if client.server_capabilities.documentHighlightProvider then
        vim.cmd [[
                    hi! LspReferenceRead cterm=bold ctermbg=red guibg=Grey
                    hi! LspReferenceText cterm=bold ctermbg=red guibg=Grey
                    hi! LspReferenceWrite cterm=bold ctermbg=red guibg=Grey
                ]]
        vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })
        vim.api.nvim_clear_autocmds { buffer = bufnr, group = "lsp_document_highlight" }
        -- vim.api.nvim_create_autocmd("CursorHold", {
        --     callback = vim.lsp.buf.document_highlight,
        --     buffer = bufnr,
        --     group = "lsp_document_highlight",
        --     desc = "Document Highlight",
        -- })
        -- vim.api.nvim_create_autocmd("CursorMoved", {
        --     callback = vim.lsp.buf.clear_references,
        --     buffer = bufnr,
        --     group = "lsp_document_highlight",
        --     desc = "Clear All the References",
        -- })
    end
    buf_set_keymap('n', '<leader>hl', '<cmd>lua vim.lsp.buf.document_highlight()<CR>', opts)
    buf_set_keymap('n', '<leader>hc', '<cmd>lua vim.lsp.buf.clear_references()<CR>', opts)
    -- for toggling diagnostics
    if vim.b[bufnr].diagnostics_disabled or vim.g.diagnostics_disabled then
        vim.diagnostic.disable(bufnr)
    end
    buf_set_keymap('n', '<leader>q', '<cmd>lua diagnostic_toggle(true)<CR>', opts)

    -- FORMAT ON SAVE
    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
    if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
                -- Python: ruff ORGANIZE IMPORTS + fixAll
                if vim.bo.filetype == "python" then
                    local params = vim.lsp.util.make_range_params()
                    params.context = { diagnostics = vim.lsp.diagnostic.get_line_diagnostics() }
                    local clients = vim.lsp.get_clients({ bufnr = 0, method = "textDocument/codeAction" })
                    if #clients > 0 then
                        local results = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
                        if results then
                            for _, result in pairs(results) do
                                for _, action in pairs(result.result or {}) do
                                    if action.kind == "source.organizeImports" then
                                        vim.lsp.buf.code_action({ context = { only = { "source.organizeImports.ruff" } }, apply = true })
                                        vim.wait(100)
                                        break
                                    end
                                    if action.kind == "source.fixAll.ruff" then
                                        vim.lsp.buf.code_action({ context = { only = { "source.fixAll.ruff" } }, apply = true })
                                        vim.wait(100)
                                        break
                                    end
                                end
                            end
                        end
                    end
                end
                -- NOW FORMAT
                vim.lsp.buf.format({ async = false })
            end,
        })
    end
end


return {
    {
        'ray-x/lsp_signature.nvim',
        event = "InsertEnter",
        opts = { bind = true, handler_opts = { border = "rounded" }, floating_window_above_cur_line = false, hint_inline = true },
        config = function(_, opts)
            require('lsp_signature').setup(opts)
            require('lsp_signature').on_attach()
        end
    },
    {
        "pmizio/typescript-tools.nvim",
        dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
        opts = {},
        config = function()
            require("typescript-tools").setup({
                on_attach = on_attach,
                capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
                ,
            })
        end
    },
    {
        "scalameta/nvim-metals",
        ft = { "scala", "sbt", "java" },
        opts = function()
            local metals_config = require("metals").bare_config()
            metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()
            metals_config.on_attach = function(client, bufnr)
                vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
                vim.keymap.set("n", "gd", '<Cmd>lua vim.lsp.buf.definition()<CR>')
                vim.keymap.set("n", "gi", '<Cmd>lua vim.lsp.buf.implementation()<CR>')
                vim.keymap.set("n", "gr", '<Cmd>Trouble lsp_references<CR>')
                vim.keymap.set("n", "<leader>k", '<Cmd>lua vim.lsp.buf.signature_help()<CR>')
                vim.keymap.set("n", "gt", '<Cmd>lua vim.lsp.buf.type_definition()<CR>')
                vim.keymap.set('n', '<leader>r', '<Cmd>lua vim.lsp.buf.rename()<CR>')
                vim.keymap.set('n', '<leader>a', '<Cmd>lua vim.lsp.buf.code_action()<CR>')
                vim.keymap.set('n', '<leader>hl', '<cmd>lua vim.lsp.buf.document_highlight()<CR>')
                vim.keymap.set('n', '<leader>hc', '<cmd>lua vim.lsp.buf.clear_references()<CR>')
            end
            metals_config.init_options.statusBarProvider = "on"
            metals_config.settings = {
                defaultBspToBuildTool = true,
                serverVersion = "1.2.2",
            }
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
            vim.opt_global.shortmess:remove("F")
        end
    },
    {
        'neovim/nvim-lspconfig',
        enable = false,
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            -- set format key maps even without sources for null-ls to work (example sqlfluff)
            vim.keymap.set('n', '+', '<cmd>lua vim.lsp.buf.format{async=true}<CR>', { noremap = true, silent = false })
            vim.keymap.set(
                'v',
                '=',
                '<cmd>lua vim.lsp.buf.format({range={["start"]=vim.api.nvim_buf_get_mark(0, "<"), ["end"]=vim.api.nvim_buf_get_mark(0, ">")}})<CR>',
                { noremap = true, silent = false }
            )

            -- for toggling diagnostics
            function diagnostic_toggle(global)
                local vars, bufnr, cmd
                if global then
                    vars = vim.g
                    bufnr = nil
                else
                    vars = vim.b
                    bufnr = 0
                end
                vars.diagnostics_disabled = not vars.diagnostics_disabled
                if vars.diagnostics_disabled then
                    cmd = 'disable'
                    vim.api.nvim_echo({ { 'Disabling diagnostics…' } }, false, {})
                else
                    cmd = 'enable'
                    vim.api.nvim_echo({ { 'Enabling diagnostics…' } }, false, {})
                end
                vim.schedule(function() vim.diagnostic[cmd](bufnr) end)
            end

            vim.diagnostic.config({
                signs = false,
                virtual_text = true,
                float = { source = true },
                underline = false,
            })
            require("mason").setup()
            require("mason-lspconfig").setup()

            local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
            -- for when not using luasnip or other snippet..
            -- capabilities.textDocument.completion.completionItem.snippetSupport = false

            local nvim_lsp = require('lspconfig')

            ---------------------------------------------------------------------------------------------------------

            nvim_lsp.pyright.setup {
                on_attach = function(client, bufnr)
                    -- overwrite on_attach to disable renaming (use pylsp-rope instead)
                    client.server_capabilities.renameProvider = false
                    return on_attach(client, bufnr)
                end,
                capabilities = capabilities,
                -- configuration: https://github.com/microsoft/pyright/blob/main/docs/settings.md
                settings = {
                    python = {
                        analysis = {
                            typeCheckingMode = 'off', -- use mypy
                            autoImportCompletions = true,
                            useLibraryCodeForTypes = true,
                        },
                    },
                    pyright = {
                        openFilesOnly = true,
                        disableOrganizeImports = true, -- use ruff
                    }
                }
            }

            nvim_lsp.pylsp.setup {
                on_attach = on_attach,
                capabilities = capabilities,
                settings = {
                    pylsp = {
                        plugins = {
                            rope_autoimport = { enabled = true, memory = true, code_actions = { enabled = true }, completions = { enabled = false } },
                            -- Disable pylsp's plugins for renaming and install pylsp-rope which handles project level renamings!
                            rope_rename = { enabled = false },
                            -- disable everything
                            autopep8 = { enabled = false },
                            flake8 = { enabled = false },
                            mccabe = { enabled = false },
                            preload = { enabled = false },
                            pycodestyle = { enabled = false },
                            pydocstyle = { enabled = false },
                            pyflakes = { enabled = false },
                            pylint = { enabled = false },
                            yapf = { enabled = false },
                            rope_completion = { enabled = false },
                            --use pyright for completions, references etc basically use only rope and extended rope from pylsp
                            jedi_completion = { enabled = false },
                            jedi_definition = { enabled = false },
                            jedi_hover = { enabled = false },
                            jedi_references = { enabled = false },
                            jedi_signature_help = { enabled = false },
                            jedi_symbols = { enabled = false },
                        }
                    }
                }
            }

            nvim_lsp.ruff.setup {
                on_attach = on_attach,
                -- on_attach = function(client, bufnr)
                --     local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
                --     vim.api.nvim_create_autocmd("BufWritePre", {
                --         group = augroup,
                --         buffer = bufnr,
                --         callback = function()
                --             vim.lsp.buf.code_action({
                --                 context = { only = { "source.fixAll" } },
                --                 apply = true,
                --             })
                --             -- https://github.com/astral-sh/ruff-lsp/issues/95#issuecomment-2232044384
                --             vim.lsp.buf.code_action({
                --                 context = { only = { "source.organizeImports.ruff" } },
                --                 apply = true,
                --             })
                --             -- vim.wait(100)
                --         end,
                --     })
                --     return on_attach(client, bufnr)
                -- end,
                capabilities = capabilities,
                trace = "messages",
                init_options = { settings = { logLevel = "debug" } }
            }
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup('lsp_attach_disable_ruff_hover', { clear = true }),
                callback = function(args)
                    local client = vim.lsp.get_client_by_id(args.data.client_id)
                    if client == nil then
                        return
                    end
                    if client.name == 'ruff' then
                        -- Disable hover in favor of Pyright
                        client.server_capabilities.hoverProvider = false
                    end
                end,
                desc = 'LSP: Disable hover capability from Ruff',
            })

            -- nvim_lsp.pylyzer.setup {
            --     on_attach = on_attach,
            --     capabilities = capabilities,
            -- }
            nvim_lsp.mojo.setup {
                on_attach = on_attach,
                capabilities = capabilities,
            }

            nvim_lsp.gopls.setup {
                on_attach = on_attach,
                capabilities = capabilities,
                cmd = { "gopls" },
                filetypes = { "go", "gomod", "gowork", "gotmpl" },
                root_dir = require('lspconfig').util.root_pattern("go.work", "go.mod", ".git"),
                settings = {
                    gopls = { completeUnimported = true, analyses = { unusedparams = true } },
                }
            }

            nvim_lsp.lua_ls.setup {
                on_attach = on_attach,
                capabilities = capabilities,
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { 'vim' }
                        },
                        workspace = {
                            library = {
                                [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                                [vim.fn.stdpath("config") .. "/lua"] = true,
                            },
                        },
                        telemetry = {
                            enable = false,
                        },
                    }
                }
            }
        end
    },
}
