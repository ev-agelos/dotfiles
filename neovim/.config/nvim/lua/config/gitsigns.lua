require('gitsigns').setup {
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', 'g]', function()
      if vim.wo.diff then return 'g]' end
      vim.schedule(function() gs.next_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    map('n', 'g[', function()
      if vim.wo.diff then return 'g[' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    -- Actions
    map('n', 'g=', gs.stage_hunk)
    map('n', 'g-', gs.reset_hunk)
    map('v', 'g=', function() gs.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
    map('v', 'g-', function() gs.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
    map('n', 'gS', gs.stage_buffer)
    map('n', 'gu', gs.undo_stage_hunk)
    map('n', 'gR', gs.reset_buffer)
    map('n', 'gp', gs.preview_hunk)
    map('n', 'gB', function() gs.blame_line{full=true} end)
    map('n', 'gb', gs.toggle_current_line_blame)
    map('n', 'gd', gs.diffthis)
    map('n', 'gD', function() gs.diffthis('~') end)
    map('n', 'gtd', gs.toggle_deleted)

    -- Text object
    map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  end,

  signs = {
    add          = {text = '▎'},
    change       = {text = '▎'},
    delete       = {text = '➤'},
    topdelete    = {text = '➤'},
    changedelete = {text = '➤'},
  },
  signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
  numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`

  watch_gitdir = {
    interval = 1000,
    follow_files = true
  },
  attach_to_untracked = true,
  current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 0,
    ignore_whitespace = false,
  },
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  max_file_length = 40000,
  preview_config = {
    -- Options passed to nvim_open_win
    border = 'single',
    style = 'minimal',
    relative = 'cursor',
    row = 0,
    col = 1
  },
}
vim.api.nvim_set_hl(0, 'GitSignsAdd', { link = 'GitSignsAdd' })
vim.api.nvim_set_hl(0, 'GitSignsAddLn', { link = 'GitSignsAddLn' })                                                                                                                                                                                            
vim.api.nvim_set_hl(0, 'GitSignsAddNr', { link = 'GitSignsAddNr' })                                                                                                                                                                                            
vim.api.nvim_set_hl(0, 'GitSignsChange', { link = 'GitSignsChange' })                                                                                                                                                                                          
vim.api.nvim_set_hl(0, 'GitSignsChangeLn', { link = 'GitSignsChangeLn' })                                                                                                                                                                                      
vim.api.nvim_set_hl(0, 'GitSignsChangeNr', { link = 'GitSignsChangeNr' })                                                                                                                                                                                      
vim.api.nvim_set_hl(0, 'GitSignsChangedelete', { link = 'GitSignsChange' })                                                                                                                                                                                    
vim.api.nvim_set_hl(0, 'GitSignsChangedeleteLn', { link = 'GitSignsChangeLn' })                                                                                                                                                                                
vim.api.nvim_set_hl(0, 'GitSignsChangedeleteNr', { link = 'GitSignsChangeNr' })                                                                                                                                                                                
vim.api.nvim_set_hl(0, 'GitSignsDelete', { link = 'GitSignsDelete' })                                                                                                                                                                                          
vim.api.nvim_set_hl(0, 'GitSignsDeleteLn', { link = 'GitSignsDeleteLn' })                                                                                                                                                                                      
vim.api.nvim_set_hl(0, 'GitSignsDeleteNr', { link = 'GitSignsDeleteNr' })                                                                                                                                                                                      
vim.api.nvim_set_hl(0, 'GitSignsTopdelete', { link = 'GitSignsDelete' })                                                                                                                                                                                       
vim.api.nvim_set_hl(0, 'GitSignsTopdeleteLn', { link = 'GitSignsDeleteLn' })                                                                                                                                                                                   
vim.api.nvim_set_hl(0, 'GitSignsTopdeleteNr', { link = 'GitSignsDeleteNr' })
