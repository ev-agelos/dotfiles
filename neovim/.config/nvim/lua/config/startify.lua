vim.keymap.set('n', '<leader>0', ':Startify<cr>')

vim.g.startify_change_to_dir = 0
vim.g.startify_update_oldfiles = 1
vim.g.startify_enable_special = 0
vim.g.startify_session_dir = '~/.config/nvim/session'
vim.g.startify_bookmarks = { os.getenv('MYVIMRC') }
vim.g.startify_custom_header = {}
vim.g.startify_list_order = {
    {'   Bookmarks:'},
    'bookmarks',
    {'   MRU:'},
    'dir',
    {'   Sessions:'},
    'sessions',
    {'   Files'},
    'files'
}
