return {
    {
        'nvimtools/none-ls.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("null-ls").setup({
                debug = false,
                default_timeout = 10000,
                temp_dir = "/tmp",
                sources = {
                    -- mypy doesnt work: https://github.com/jose-elias-alvarez/null-ls.nvim/issues/1208
                    require('null-ls').builtins.diagnostics.mypy.with({
                        extra_args = { "--config-file", "pyproject.toml" },
                        runtime_condition = function(params)
                            return require('null-ls.utils').path.exists(params.bufname)
                        end,
                    }),
                    -- use ruff(black+isort equivelant) from ruff-lsp
                    -- require("null-ls").builtins.formatting.isort,
                    -- require("null-ls").builtins.formatting.black,
                    -- require("null-ls").builtins.diagnostics.vulture,
                    -- require('null-ls').builtins.diagnostics.pylint,
                    require("null-ls").builtins.formatting.sqlfluff.with({
                        extra_args = { "--dialect", "postgres" }, -- change to your dialect
                    }),
                    require("null-ls").builtins.diagnostics.sqlfluff.with({
                        extra_args = { "--dialect", "postgres" }, -- change to your dialect
                    })
                },
            })
        end
    }
}
