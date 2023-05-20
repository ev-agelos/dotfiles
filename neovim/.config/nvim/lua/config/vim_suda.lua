vim.api.nvim_create_user_command(
    "SudoRead",
    "edit suda://<args>",
    {bang=true, nargs=1}
)

vim.api.nvim_create_user_command(
    "SudoWrite",
    "write suda://<args>",
    {bang=true, nargs=1}
)
