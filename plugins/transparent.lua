return {
  "xiyaowong/transparent.nvim",
  lazy = false,
  config = function()
    require "transparent".setup({
      exclude_groups = {},
      extra_groups = {
        "DashboardHeader", "DashboardCenter", "DashboardShortcut", "DashboardFooter",
      },
    })
  end
}
