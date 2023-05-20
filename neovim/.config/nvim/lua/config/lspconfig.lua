local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

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
  buf_set_keymap('n', 'F', '<cmd>lua vim.lsp.buf.format{async=true}<CR>', opts)
  vim.fn.sign_define("DiagnosticSignError", { text = "✗", texthl = "DiagnosticSignError" })
  vim.fn.sign_define("DiagnosticSignWarn", { text = "!", texthl = "DiagnosticSignWarn" })
  vim.fn.sign_define("DiagnosticSignInformation", { text = "", texthl = "DiagnosticSignInfo" })
  vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })

  -- highlight under cursor
  if client.server_capabilities.documentHighlightProvider then
      vim.cmd [[
      hi! LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
      hi! LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
      hi! LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
      ]]
      vim.api.nvim_create_augroup('lsp_document_highlight', {
          clear = false
      })
      vim.api.nvim_clear_autocmds({
          buffer = bufnr,
          group = 'lsp_document_highlight',
      })
      -- make it keymap instead of autocommand
      -- vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
      --     group = 'lsp_document_highlight',
      --     buffer = bufnr,
      --     callback = vim.lsp.buf.document_highlight,
      -- })
      vim.api.nvim_create_autocmd({'CursorMoved', 'InsertEnter'}, {
          group = 'lsp_document_highlight',
          buffer = bufnr,
          callback = vim.lsp.buf.clear_references,
      })
  end
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
--local lsp_installer = require("nvim-lsp-installer")
--lsp_installer.on_server_ready(function(server)
--    local opts = {}
--    --if server.name == 'pylsp' then
--    --    opts.cmd = {'/home/evangelos/.local/share/nvim/lsp_servers/pylsp/venv/bin/pylsp'}
--    --    opts.on_attach = on_attach
--    --    opts.settings = {
--    --        pylsp = {
--    --            plugins = {
--    --                rope_autoimport={enabled=true, memory=true},
--    --                -- false
--    --                pyflakes = {enabled=false},
--    --                mccabe = {enabled=false},
--    --                pycodestyle = {enabled=false},
--    --                pydocstyle = {enabled=false},
--    --                autopep8={enabled=false},
--    --                yapf = {enabled=false},
--    --                flake8={enabled=false, maxLineLength=88},
--    --                pylint={enabled=false},
--    --                preload={enabled=false},
--    --                --use pyright for completions, references etc basically use only rope and extended rope from pylsp
--    --                jedi_completion = {enabled=false},
--    --                jedi_definition = {enabled=false},
--    --                jedi_hover = {enabled=false},
--    --                jedi_references = {enabled=false},
--    --                jedi_signature_help = {enabled=false},
--    --                jedi_symbols = {enabled=false},
--    --            }
--    --        }
--    --    }
--    --end
--    if server.name == 'pyright' then
--        opts.settings = {python={analysis={typeCheckingMode='basic'}}, pyright={disableOrganizeImports=true}}
--    end

--    -- stop complaining for undefined global vim
--    if server.name == 'sumneko_lua' then
--        opts.settings = {
--            Lua = {
--                diagnostics = { globals = {  'vim' } }
--            }
--        }
--    end
--    -- Setup lspconfig.
--    local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
--    opts.capabilities=capabilities
--    server:setup(opts)
--    vim.diagnostic.config({
--        signs=false,
--        virtual_text=false,
--        float={source=always},
--        underline=false,
--    })
--end)


vim.diagnostic.config({
    signs=false,
    virtual_text=false,
    float={source=always},
    underline=false,
})

require("mason").setup()
require("mason-lspconfig").setup()

local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

nvim_lsp.pyright.setup{
    on_attach=on_attach,
    capabilities=capabilities,
    settings={
        python={
            analysis={
                typeCheckingMode='basic'
            }
        },
        -- pyright = {
        --     disableOrganizeImports=true
        -- }
    }
}
nvim_lsp.pylsp.setup{
    on_attach=on_attach,
    capabilities=capabilities,
    settings={
        pylsp = {
            plugins = {
                rope_autoimport={enabled=true, memory=true},
                -- false
                pyflakes = {enabled=false},
                mccabe = {enabled=false},
                pycodestyle = {enabled=false},
                pydocstyle = {enabled=false},
                autopep8={enabled=false},
                yapf = {enabled=false},
                flake8={enabled=false, maxLineLength=88},
                pylint={enabled=false},
                preload={enabled=false},
                --use pyright for completions, references etc basically use only rope and extended rope from pylsp
                jedi_completion = {enabled=false},
                jedi_definition = {enabled=false},
                jedi_hover = {enabled=false},
                jedi_references = {enabled=false},
                jedi_signature_help = {enabled=false},
                jedi_symbols = {enabled=false},
            }
        }
    }
}

nvim_lsp.solidity.setup{
    on_attach=on_attach,
    capabilities=capabilities,
}
nvim_lsp.solidity_ls.setup{
    on_attach=on_attach,
    capabilities=capabilities,
    settings = {
        -- example of global remapping
        solidity = { includePath = '', remapping = { ["@OpenZeppelin/"] = 'OpenZeppelin/openzeppelin-contracts@4.6.0/' } }
    },
}
-- nvim_lsp.solhint.setup{
--     on_attach=on_attach,
--     capabilities=capabilities,
-- }

local configs = require 'lspconfig.configs'
if not configs.ruff_lsp then
  configs.ruff_lsp = {
    default_config = {
      cmd = { 'ruff-lsp' },
      filetypes = { 'python' },
      root_dir = require('lspconfig').util.find_git_ancestor,
      init_options = {
        settings = {
          args = {}
        }
      }
    }
  }
end
require('lspconfig').ruff_lsp.setup {
  on_attach = on_attach,
  capabilities=capabilities,
}

