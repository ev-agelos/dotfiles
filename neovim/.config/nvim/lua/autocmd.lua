-- local nosmartindentpython = vim.api.nvim_create_augroup("NoSmartIndentPython", { clear = true })

-- vim.api.nvim_create_autocmd("FileType", {
--     command="setlocal nosmartindent",
--     pattern="*.py",
--     desc="Disable smartindent in python files(messing up hash commenting symbol)",
--     group=nosmartindentpython,
-- })
vim.api.nvim_create_autocmd({"TextYankPost"}, {
    command="lua vim.highlight.on_yank()",
    desc="Highlight on yank",
})

vim.api.nvim_create_autocmd({ "InsertLeave", "CompleteDone" }, {
    command="if pumvisible() == 0 | pclose | endif",
    desc="Hide the preview window when leaving insert mode or completion is done",
})

vim.api.nvim_create_autocmd("InsertEnter", {
    command="set nohlsearch",
    desc="Removes highlight when in insert mode",
})


vim.api.nvim_create_autocmd("BufReadPost", {
    callback=function()
        if vim.fn.line([['"]]) > 1 and vim.fn.line([['"]]) <= vim.fn.line("$") then
            vim.cmd([[normal! g'"]])
        end
    end,
    desc="jump to last position when reopening a file",
})
vim.api.nvim_create_autocmd("BufLeave", {
    command="let b:winview = winsaveview()",
    desc="save last cursor position",
})
vim.api.nvim_create_autocmd("BufEnter", {
    command="if(exists('b:winview')) | call winrestview(b:winview) | endif",
    desc="place cursor on last saved position",
})

-- messes up when completion window is closed!
-- vim.api.nvim_create_autocmd("WinClosed", {
--     command=":normal <C-W>=",
--     desc="equal window sizes when closing a window"
-- })

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "sql", "mysql", "plsql" },
  command = ":lua require('cmp').setup.buffer({ sources = {{ name = 'vim-dadbod-completion' }} })",
})



function org_imports()
  local clients = vim.lsp.buf_get_clients()
  for _, client in pairs(clients) do

    local params = vim.lsp.util.make_range_params(nil, client.offset_encoding)
    params.context = {only = {"source.organizeImports"}}

    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 5000)
    for _, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          vim.lsp.util.apply_workspace_edit(r.edit, client.offset_encoding)
        else
          vim.lsp.buf.execute_command(r.command)
        end
      end
    end
  end
end

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.go" },
  callback = vim.lsp.buf.format,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.go" },
  callback = org_imports,
})
