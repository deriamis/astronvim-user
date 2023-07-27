return {
  "nvim-telescope/telescope.nvim",
  dependencies = { -- add a new dependency to telescope that is our new plugin
    "nvim-telescope/telescope-media-files.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
    "nvim-telescope/telescope-fzf-native.nvim",
    "nvim-telescope/telescope-frecency.nvim",
    "nvim-telescope/telescope-live-grep-args.nvim",
    "nvim-telescope/telescope-file-browser.nvim",
    "nvim-telescope/telescope-symbols.nvim",
  },
  -- the first parameter is the plugin specification
  -- the second is the table of options as set up in Lazy with the `opts` key
  config = function(plugin, opts)
    -- run the core AstroNvim configuration function with the options table
    require("plugins.configs.telescope")(plugin, opts)

    -- require telescope and load extensions as necessary
    local telescope = require "telescope"
    local telescope_themes = require "telescope.themes"
    local lga_actions = require "telescope-live-grep-args.actions"

    telescope.load_extension "media_files"
    telescope.load_extension "ui-select"
    telescope.load_extension "fzf"
    telescope.load_extension "frecency"
    telescope.load_extension "live_grep_args"
    telescope.load_extension "file_browser"

    return {
      extensions = {
        ["ui-select"] = {
          telescope_themes.get_dropdown()
        },
        ["fzf"] = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case"
        },
        ["frecency"] = {
          auto_validate = false,
        },
        ["live_grep_args"] = {
          auto_quoting = true,
          mappings = {
            i = {
              ["<C-k>"] = lga_actions.quote_prompt(),
              ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
            },
          },
        },
      },
    }
  end,
}
