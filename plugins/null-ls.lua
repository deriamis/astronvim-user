local null_ls = require "null-ls"

return {
    "jay-babu/mason-null-ls.nvim",
    opts = {
        sources = {
            null_ls.builtins.formatting.stylua,
            -- null_ls.builtins.formatting.prettier,
            -- null_ls.builtins.formatting.black,
            null_ls.builtins.formatting.isort,
            null_ls.builtins.formatting.clang_format,
            null_ls.builtins.formatting.rustfmt,
            null_ls.builtins.formatting.shfmt.with {args = {"-i", "2"}},
            null_ls.builtins.diagnostics.luacheck,
            -- null_ls.builtins.diagnostics.flake8,
            null_ls.builtins.diagnostics.pylint,
            null_ls.builtins.diagnostics.mypy
        },
        handlers = {
            prettier = function()
                require("null-ls").register(
                    require("null-ls").builtins.formatting.prettier.with {
                        condition = function(utils)
                            return utils.root_has_file "package.json" or
                                       utils.root_has_file ".prettierrc" or
                                       utils.root_has_file ".prettierrc.json" or
                                       utils.root_has_file ".prettierrc.js"
                        end
                    })
            end,
            prettierd = function()
                require("null-ls").register(
                    require("null-ls").builtins.formatting.prettierd.with {
                        condition = function(utils)
                            return utils.root_has_file "package.json" or
                                       utils.root_has_file ".prettierrc" or
                                       utils.root_has_file ".prettierrc.json" or
                                       utils.root_has_file ".prettierrc.js"
                        end
                    })
            end,
            eslint_d = function()
                require("null-ls").register(
                    require("null-ls").builtins.diagnostics.eslint_d.with {
                        condition = function(utils)
                            return utils.root_has_file "package.json" or
                                       utils.root_has_file ".eslintrc.json" or
                                       utils.root_has_file ".eslintrc.js"
                        end
                    })
            end
        }
    }
}
