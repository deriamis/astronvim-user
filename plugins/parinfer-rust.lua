return {
  "eraserhd/parinfer-rust",
  build = "cargo build --release",
  config = function(plugin)
    vim.opt.rtp:append(plugin.dir .. "/target/release")
  end,
}
