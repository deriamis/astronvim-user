return {
  "ahmedkhalf/project.nvim",
  lazy = false,
  config = function()
    require "project_nvim".setup({
      patterns = {
        ".git", "_darcs", ".hg", ".svn", "CVS", "Makefile", "*.sln", "package.json",
      }
    })
  end,
}
