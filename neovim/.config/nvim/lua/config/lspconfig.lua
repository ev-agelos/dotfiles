-- set format key maps even without sources for null-ls to work (example sqlfluff)
vim.keymap.set('n', 'F', '<cmd>lua vim.lsp.buf.format{async=true}<CR>', { noremap = true, silent = false })
vim.keymap.set('v', '=', '<ESC><cmd>lua vim.lsp.buf.format()<CR>', { noremap = true, silent = false })

local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    -- Enable completion triggered by <c-x><c-o>
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    local opts = { noremap = true, silent = false }

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    buf_set_keymap('n', 'fD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'fd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'vfd', '<cmd>vsplit | lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'fk', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'fi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', 'fs', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    -- buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    -- buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    -- buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    buf_set_keymap('n', 'ft', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    buf_set_keymap('n', 'fr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    -- buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
    buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
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
    buf_set_keymap('n', 'ff', '<cmd>lua vim.lsp.buf.document_highlight()<CR>', opts)
    buf_set_keymap('n', 'fc', '<cmd>lua vim.lsp.buf.clear_references()<CR>', opts)
    -- for toggling diagnostics
	if vim.b[bufnr].diagnostics_disabled or vim.g.diagnostics_disabled then
		vim.diagnostic.disable(bufnr)
	end
    buf_set_keymap('n', 'fq', '<cmd>lua diagnostic_toggle(true)<CR>', opts)
end

vim.diagnostic.config({
    signs = false,
    virtual_text = true,
    float = { source = always },
    underline = false,
})

require("mason").setup()
require("mason-lspconfig").setup()

local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.completion.completionItem.snippetSupport = false


nvim_lsp.pyright.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        python = {
            analysis = {
                typeCheckingMode = 'off',
                autoImportCompletions = true,
            },
            useLibraryCodeForTypes = true
        },
        -- pyright = {
        --     disableOrganizeImports=true
        -- }
    }
}

require'lspconfig'.mojo.setup{
    on_attach = on_attach,
    capabilities = capabilities,
}

--nvim_lsp.pylsp.setup {
--    on_attach = on_attach,
--    capabilities = capabilities,
--    settings = {
--        pylsp = {
--            plugins = {
--                rope_autoimport = { enabled = true, memory = true },
--                -- false
--                pyflakes = { enabled = false },
--                mccabe = { enabled = false },
--                pycodestyle = { enabled = false },
--                pydocstyle = { enabled = false },
--                autopep8 = { enabled = false },
--                yapf = { enabled = false },
--                flake8 = { enabled = false, maxLineLength = 88 },
--                pylint = { enabled = false },
--                preload = { enabled = false },
--                --use pyright for completions, references etc basically use only rope and extended rope from pylsp
--                jedi_completion = { enabled = false },
--                jedi_definition = { enabled = false },
--                jedi_hover = { enabled = false },
--                jedi_references = { enabled = false },
--                jedi_signature_help = { enabled = false },
--                jedi_symbols = { enabled = false },
--            }
--        }
--    }
--}

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

-- local configs = require 'lspconfig.configs'
-- if not configs.ruff_lsp then
--   configs.ruff_lsp = {
--     default_config = {
--       cmd = { 'ruff-lsp' },
--       filetypes = { 'python' },
--       root_dir = require('lspconfig').util.find_git_ancestor,
--       init_options = {
--         settings = {
--           args = {}
--         }
--       }
--     }
--   }
-- end
require('lspconfig').ruff_lsp.setup {
    on_attach = function(client, bufnr)
        -- Disable hover in favor of Pyright
        client.server_capabilities.hoverProvider = false
    end,
    capabilities = capabilities,
    init_options = {
        settings = {
            -- Any extra CLI arguments for `ruff` go here.
            args = {},
        }
    }
}

require('lspconfig').rust_analyzer.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}

require('lspconfig').tsserver.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}

require('lspconfig').hls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}

require('lspconfig').lua_ls.setup {
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


