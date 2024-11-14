vim.opt.path:append('**')
vim.opt.autoread = false
vim.opt.clipboard:append('unnamedplus')
vim.opt.cursorline = false
vim.opt.equalalways = true
vim.opt.expandtab = true
vim.opt.fixeol = false
vim.opt.foldlevel = 99
vim.opt.foldmethod = 'indent'
vim.opt.formatoptions:append('t')
vim.opt.guicursor = 'n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor'
vim.opt.ignorecase = true
vim.opt.inccommand = 'split'
vim.opt.laststatus = 3
vim.opt.linebreak = true
vim.opt.mouse = 'a'
vim.opt.report = 0
vim.opt.scrolloff = 0
vim.opt.shiftround = true
vim.opt.shiftwidth = 4
vim.opt.shortmess:append('a')
vim.opt.showmatch = true
vim.opt.showmode = true
vim.opt.sidescrolloff = 5
vim.opt.smartcase = false
vim.opt.smartindent = false -- use treesitter
vim.opt.softtabstop = 4
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.startofline = false
vim.opt.swapfile = false
vim.opt.tabstop = 4
vim.opt.undofile = true
vim.opt.undolevels = 1000
vim.opt.updatetime = 300
vim.opt.virtualedit = 'block'
vim.opt.wildignore:append({ '*.o', '*.obj', '.git', '*.pyc', 'eggs/**', '*.eggs-info/**' })
vim.opt.wildignorecase = true
vim.opt.wildmode = 'full'
vim.opt.wrap = false
vim.opt.wrapscan = true
vim.opt.completeopt = "menu,menuone,noselect"
vim.opt.termguicolors = true
vim.opt.background = 'dark'
