-- local nosmartindentpython = vim.api.nvim_create_augroup("NoSmartIndentPython", { clear = true })

-- vim.api.nvim_create_autocmd("FileType", {
--     command="setlocal nosmartindent",
--     pattern="*.py",
--     desc="Disable smartindent in python files(messing up hash commenting symbol)",
--     group=nosmartindentpython,
-- })

vim.api.nvim_create_autocmd({ "InsertLeave", "CompleteDone" }, {
    command="if pumvisible() == 0 | pclose | endif",
    desc="Hide the preview window when leaving insert mode or completion is done",
})

vim.api.nvim_create_autocmd("InsertEnter", {
    command="set nohlsearch",
    desc="Removes highlight when in insert mode",
})


local TrimWhiteSpaceGrp = vim.api.nvim_create_augroup("TrimWhiteSpaceGrp", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
    command=[[%s/\s\+$//e]],
    pattern="*.py",
    desc="trim whitespace before save",
    group=TrimWhiteSpaceGrp,
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

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost init.lua source <afile> | PackerCompile
  augroup end
]])
