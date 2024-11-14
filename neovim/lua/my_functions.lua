-- easier printing when debugging stuff
P = function(v)
    print(vim.inspect(v))
    return v
end


local api = vim.api

local next_buffer = function(start, stop, step)
    local current_buffer = api.nvim_get_current_buf()
    local total_items = 0
    local next_buffer = nil
    local index = {}

    for i = start, stop, step do
        local v = api.nvim_list_bufs()[i]
        if vim.fn.buflisted(v) == 1 then
            if vim.fn.bufwinnr(v) == -1 then
                total_items = total_items + 1
                index[total_items] = v
            end
            if v == current_buffer then
                next_buffer = total_items + 1
            end
        end
    end
    if not total_items or not next(index) then
        return
    end

    local buffer = -1
    if next_buffer == nil then -- we are in directory view for example
        buffer = vim.fn.bufnr("#")
    elseif next_buffer == total_items + 1 then
        buffer = index[1]
    else
        buffer = index[next_buffer]
    end
    if not pcall(api.nvim_win_set_buf, 0, buffer) then
        print("my error: ", buffer, next_buffer, vim.inspect(index))
    end
end

local M = {}
function M.forward()
    next_buffer(1, #api.nvim_list_bufs(), 1)
end

function M.backward()
    next_buffer(#api.nvim_list_bufs(), 1, -1)
end

function M.delete()
    if vim.bo.filetype == "fugitive" or vim.bo.filetype == "help" or vim.bo.filetype == "qf" then
        api.nvim_win_close(0, false)
        vim.cmd("normal zz")
        return
    end

    local current = api.nvim_get_current_buf()
    local other = vim.fn.bufnr('#')
    local total_windows = vim.fn.winnr('$')
    local total_buffers = vim.fn.len(vim.fn.getbufinfo({ buflisted = 1 }))

    -- previous is listed and different from current and previous is not on a window
    if vim.fn.buflisted(other) ~= 0 and other ~= current and vim.fn.bufwinnr(other) == -1 then
        -- bring previous to front
        api.nvim_win_set_buf(0, other)
    elseif total_buffers > total_windows then
        M.forward()
    else
        local ok, _ = pcall(vim.cmd, 'bdelete')
        if not ok then
            print('No write')
            return
        end
    end

    if vim.fn.buflisted(current) ~= 0 then -- does code come here also for Git blame?
        local ok, _ = pcall(vim.cmd, 'bdelete #')
        if not ok then
            print('No write????')
            api.nvim_win_set_buf(0, current) -- dont change buffer stay at the same
            return
        end
    end

    if vim.fn.len(vim.fn.getbufinfo({ buflisted = 1 })) < vim.fn.winnr('$') then
        api.nvim_win_close(0, false)
    end
end

function M.vsplit()
    local current_buffer = api.nvim_get_current_buf()
    M.forward()
    vim.cmd('vsplit')
    api.nvim_win_set_buf(0, current_buffer)
end

vim.keymap.set('n', 'q', ":lua require'my_functions'.delete()<CR>", { silent = true })
-- vim.keymap.set('n', '<Leader>vs', ":lua require'my_functions'.vsplit()<CR>", {silent=true})
vim.keymap.set('n', 'gn', ":lua require'my_functions'.forward()<CR>", { silent = true })  --to next hidden buffer
vim.keymap.set('n', 'gp', ":lua require'my_functions'.backward()<CR>", { silent = true }) --to previous hidden buffer

return M
