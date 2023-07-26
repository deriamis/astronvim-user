return {
"harrygallagher4/nvim-parinfer-rust",
  ft = "lisp",
  dependencies = {
    "eraserhd/parinfer-rust",
  },
  config = function()
    vim.api.nvim_create_autocmd(
      "VimEnter",
      { callback = function() require "parinfer".setup() end }
    )
  end,
}
