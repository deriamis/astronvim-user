return {
  "stevearc/resession.nvim",
  event = "BufWritePost",
  keys = { "<leader>S" },
  config = function(_, opts)
    local utils = require "astronvim.utils"
    require "resession".setup(utils.extend_tbl(opts, {
      autosave = {
        enabled = true,
        interval = 60,
        notify = true,
      },
    }))
  end,
}
