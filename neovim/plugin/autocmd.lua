-- Debug events
-- vim.api.nvim_create_autocmd(
--     {
--         "BufAdd", "BufDelete", "BufEnter", "BufFilePost", "BufFilePre", "BufHidden", "BufLeave", "BufModifiedSet",
--         "BufNew", "BufNewFile", "BufRead", "BufReadPost", "BufReadCmd", "BufReadPre", "BufUnload", "BufWinEnter",
--         "BufWinLeave", "BufWipeout", "BufWrite", "BufWritePre", "BufWriteCmd", "BufWritePost", "ChanInfo", "ChanOpen",
--         "CmdUndefined", "CmdlineChanged", "CmdlineEnter", "CmdlineLeave", "CmdwinEnter", "CmdwinLeave", "ColorScheme",
--         "ColorSchemePre", "CompleteChanged", "CompleteDonePre", "CompleteDone", "CursorHold", "CursorHoldI",
--         "CursorMoved", "CursorMovedI", "DiffUpdated", "DirChanged", "DirChangedPre", "ExitPre", "FileAppendCmd",
--         "FileAppendPost", "FileAppendPre", "FileChangedRO", "FileChangedShell", "FileChangedShellPost", "FileReadCmd",
--         "FileReadPost", "FileReadPre", "FileType", "FileWriteCmd", "FileWritePost", "FileWritePre", "FilterReadPost",
--         "FilterReadPre", "FilterWritePost", "FilterWritePre", "FocusGained", "FocusLost", "FuncUndefined", "UIEnter",
--         "UILeave", "InsertChange", "InsertCharPre", "InsertEnter", "InsertLeavePre", "InsertLeave", "MenuPopup",
--         "ModeChanged", "OptionSet", "QuickFixCmdPre", "QuickFixCmdPost", "QuitPre", "RemoteReply", "SearchWrapped",
--         "RecordingEnter", "RecordingLeave", "SafeState", "SessionLoadPost", "SessionWritePost", "ShellCmdPost", "Signal",
--         "ShellFilterPost", "SourcePre", "SourcePost", "SourceCmd", "SpellFileMissing", "StdinReadPost", "StdinReadPre",
--         "SwapExists", "Syntax", "TabEnter", "TabLeave", "TabNew", "TabNewEntered", "TabClosed", "TermOpen", "TermEnter",
--         "TermLeave", "TermClose", "TermRequest", "TermResponse", "TextChanged", "TextChangedI", "TextChangedP",
--         "TextChangedT", "TextYankPost", "User", "VimEnter", "VimLeave", "VimLeavePre", "VimResized", "VimResume",
--         "VimSuspend", "WinClosed", "WinEnter", "WinLeave", "WinNew", "WinScrolled", "WinResized",
--     },
--     {
--         callback = function(args)
--             print("Event: " .. args.event .. " triggered in buffer " .. args.buf)
--         end,
--     }
-- )



-- local nosmartindentpython = vim.api.nvim_create_augroup("NoSmartIndentPython", { clear = true })

-- vim.api.nvim_create_autocmd("FileType", {
--     command="setlocal nosmartindent",
--     pattern="*.py",
--     desc="Disable smartindent in python files(messing up hash commenting symbol)",
--     group=nosmartindentpython,
-- })
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
    command = "lua vim.highlight.on_yank()",
    desc = "Highlight on yank",
})

vim.api.nvim_create_autocmd({ "InsertLeave", "CompleteDone" }, {
    command = "if pumvisible() == 0 | pclose | endif",
    desc = "Hide the preview window when leaving insert mode or completion is done",
})

vim.api.nvim_create_autocmd("InsertEnter", {
    command = "set nohlsearch",
    desc = "Removes highlight when in insert mode",
})


vim.api.nvim_create_autocmd("BufReadPost", {
    callback = function()
        if vim.fn.line([['"]]) > 1 and vim.fn.line([['"]]) <= vim.fn.line("$") then
            vim.cmd([[normal! g'"zz]])
        end
    end,
    desc = "jump to last position when reopening a file and center screen",
})
vim.api.nvim_create_autocmd("BufLeave", {
    command = "let b:winview = winsaveview()",
    desc = "save last cursor position",
})
vim.api.nvim_create_autocmd("BufEnter", {
    command = "if(exists('b:winview')) | call winrestview(b:winview) | endif",
    desc = "place cursor on last saved position",
})

-- messes up when completion window is closed!
-- vim.api.nvim_create_autocmd("WinClosed", {
--     command=":normal <C-W>=",
--     desc="equal window sizes when closing a window"
-- })

-- vim.api.nvim_create_augroup('MyWinNewGroup', { clear = true })
-- vim.api.nvim_create_augroup('MyWinNewGroup2', { clear = true })
-- vim.api.nvim_create_autocmd('WinNew', {
--     group = "MyWinNewGroup",
--     callback = function()
--         local total_windows = vim.fn.winnr('$')
--         local total_buffers = vim.fn.len(vim.fn.getbufinfo({ buflisted = 1 }))
--         if total_windows <= total_buffers then
--             vim.cmd("bnext")
--         else
--             vim.api.nvim_create_autocmd('WinEnter', {
--                 group = "MyWinNewGroup2",
--                 callback = function()
--                     vim.cmd.ls()
--                     vim.api.nvim_clear_autocmds({ group = 'MyWinNewGroup2' })
--                 end
--             })
--         end
--     end,
-- })




-- GO
function org_imports()
    local clients = vim.lsp.buf_get_clients()
    for _, client in pairs(clients) do
        local params = vim.lsp.util.make_range_params(nil, client.offset_encoding)
        params.context = { only = { "source.organizeImports" } }

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
