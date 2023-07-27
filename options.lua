return {
    -- set vim options here (vim.<first_key>.<second_key> =  value)
    opt = {
        -- set to true or false etc.
        lazyredraw = false,
        relativenumber = true,               -- sets vim.opt.relativenumber
        number = true,                       -- sets vim.opt.number
        spell = true,                        -- sets vim.opt.spell
        spelllang = { "en_us" },
        signcolumn = "yes",                  -- sets vim.opt.signcolumn to always displaqy
        wrap = true,                         -- sets vim.opt.wrap
        conceallevel = 2,                    -- enable conceal
        foldenable = false,
        foldexpr = "nvim_treesitter#foldexpr()", -- set Treesitter based folding
        foldmethod = "expr",
        linebreak = true,                    -- linebreak soft wrap at words
        list = true,                         -- show whitespace characters
        -- listchars = { tab = " ", extends = "⟩", precedes = "⟨", trail = "·", eol = "﬋" },
        showbreak = "﬌ ",
        colorcolumn = "80,100",
        guifont = "InconsolataLGC Nerd Font",
        linespace = 2,
    },
    g = {
        git_worktrees = {
            {
                toplevel = vim.env.HOME,
                gitdir = vim.env.HOME .. "/.dotfiles"
            },
        },
        python3_host_prog = "~/.asdf/shims/python3",
        mapleader = " ",               -- sets vim.g.mapleader
        autoformat_enabled = false,    -- enable or disable auto formatting at start (lsp.formatting.format_on_save must be enabled)
        markdown_fenced_languages = { "ts=typescript" },
        cmp_enabled = true,            -- enable completion at start
        autopairs_enabled = true,      -- enable autopairs at start
        diagnostics_enabled = true,    -- enable diagnostics at start
        status_diagnostics_enabled = true, -- enable diagnostics in statusline
        icons_enabled = true,          -- disable icons in the UI (disable if no nerd font is available, requires :PackerSync after changing)
        neovide_theme = "dark",
        neovide_transparency = 0.0,
        neovide_background_color = "#171717" .. string.format("%x", 255 * 0.95),
        neovide_hide_mouse_when_typing = true,
        neovide_fullscreen = true,
        neovide_cursor_vfx_mode = "sonicboom",
        nvlime_cl_use_terminal = false,
        nvlime_config = {
            implementation = "mondo",
            autodoc = { enabled = true },
            cmp = { enabled = true },
        },
    },
}
