return {
    {
        'mhinz/vim-startify',
        config = function()
            function Projects()
                return function()
                    -- get workspace projects (with git) ordered by last modified
                    local cmd_output = vim.fn.systemlist('ls -dt ~/workspace/* | xargs -I{} git -C {} rev-parse --show-toplevel 2>/dev/null')
                    local files =
                        vim.tbl_map(
                        function(v)
                            return {line = v, path = v}
                        end,
                        cmd_output
                    )
                    return files
                end
            end

            local StartifyGroup = vim.api.nvim_create_augroup('StartifyGroup', {clear=true})
            vim.api.nvim_create_autocmd("User", {
                group=StartifyGroup,
                pattern='StartifyBufferOpened',
                callback = function(event)
                    local projects_dir = os.getenv('HOME') .. '/workspace'
                    local dirpath_with_maybe_protocol = vim.fn.expand('%:p:h')
                    local dirpath = dirpath_with_maybe_protocol:match('/[a-zA-Z0-9_.].+')
                    local under_projects = dirpath:find(projects_dir) ~= nil
                    if not under_projects then return
                    end
                    local has_git = os.execute('git -C ' .. dirpath .. ' rev-parse 2>/dev/null') == 0
                    if not has_git then return
                    end
                    local project_path = vim.fn.system('git -C ' .. dirpath .. ' rev-parse --show-toplevel 2>/dev/null')
                    local project_name = vim.fn.trim(project_path):match('[a-zA-Z0-9_-]+$')
                    if project_name == nil then return
                    end
                    vim.cmd('SSave! ' .. project_name)
                end,
                desc="Auto save session if opened buffer is under a project in ~/workspace",
            })


            vim.keymap.set('n', '\\', ':Startify<cr>')

            vim.g.startify_change_to_dir = 0  -- setting to 1 changes to nvim directory..?
            vim.g.startify_session_persistence = 1
            vim.g.startify_update_oldfiles = 1
            vim.g.startify_enable_special = 0
            vim.g.startify_session_dir = '~/.config/nvim/session'
            vim.g.startify_bookmarks = {
                {c='~/.config/nvim/lua/config'}
            }
            vim.g.startify_custom_header = {}
            vim.g.startify_lists = {
                { header= {"   Files "}, type= "files" },
                { header= {"   Sessions "}, type= "sessions" },
                { header= {"   Git Projects "}, type= Projects() },
                { header= {"   Bookmarks "}, type= "bookmarks" },
            }
        end
    }
}
