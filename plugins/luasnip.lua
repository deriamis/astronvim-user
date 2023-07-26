return {
  "L3MON4D3/LuaSnip",
  config = function(plugin, opts)
    -- include the default astronvim config that calls the setup call
    require "plugins.configs.luasnip"(plugin, opts)

    local user_config_path
    if vim.fn.has("macunix") then
      user_config_path = vim.loop.os_homedir() .. "/Library/Application Support"
    else
      user_config_path = vim.loop.os_homedir() .. "/.config"
    end

    -- load snippets paths
    require("luasnip.loaders.from_vscode").lazy_load {
      -- this can be used if your configuration lives in ~/.config/nvim
      -- if your configuration lives in ~/.config/astronvim, the full path
      -- must be specified in the next line
      paths = { user_config_path .. "/Code/User/snippets" }
    }
  end,
}
