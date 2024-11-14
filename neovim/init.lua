-- Install lazy.nvim if not already installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end

-- Add lazy to the `runtimepath`, this allows us to `require` it.
vim.opt.rtp:prepend(lazypath)

-- leader must be mapped before Lazy
vim.keymap.set("", "<Space>", "<Nop>")
vim.g.mapleader = " "

require('my_functions')
require("lazy").setup({ import = "config" }, {
  change_detection = {
    notify = false,
  },
})
