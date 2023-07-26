-- This function is run last and is a good place to configuring
-- anything that doesn't fit in the normal config can go here
return function()
  if vim.fn.has("gui_running") then
    vim.api.nvim_command("TransparentEnable")
  else
    vim.api.nvim_command("TransparentDisable")
  end

  require "user.autocmds"

  if vim.fn.exists "$TMUX" == 1 then
    local has_tmux, _ = pcall(require, "tmux")
    if has_tmux then
      require("tmux").setup {
        copy_sync = { enable = false },
        navigation = {
          cycle_navigation = true,
          enable_default_keybindings = true,
        },
        resize = { enable_default_keybindings = true },
      }
    end
  end

  -- FileType
  vim.filetype.add {
    extension = { conf = "config" },
    filename = { ["CmakeLists.txt"] = "cmake", [".clang-format"] = "yaml" },
  }
end
