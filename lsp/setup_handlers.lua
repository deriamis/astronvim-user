return {
  jdtls = function(_, opts)
    if vim.bo.filetype == "java" then
      require("jdtls").start_or_attach(opts)
    end
  end,
  clangd = function(_, opts) require("clangd_extensions").setup { server = opts } end,
  rust_analyzer = function(_, opts) require("rust-tools").setup { server = opts } end,
}
