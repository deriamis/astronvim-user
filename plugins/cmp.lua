return {
  "hrsh7th/nvim-cmp",
  keys = { ":", "/", "?" },
  dependencies = {
    "hrsh7th/cmp-cmdline",
    "ryo33/nvim-cmp-rust",
    "monkoose/nvlime",
  },
  config = function(_, opts)
    local cmp = require "cmp"
    local cmp_rust = require "cmp-rust"
    cmp.setup(opts)

    cmp.setup.cmdline("/", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer" },
      },
    })
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "path" },
      }, {
          {
            name = "cmdline",
            option = {
              ignore_cmds = { "Man", "!" },
            }
          }
        })
    })
    cmp.setup.filetype({"lisp"}, {
      sources = cmp.config.sources({
        { name = "nvlime", priority = 700 }
      })
    })
    cmp.setup.filetype({"rust"}, {
      sorting = {
        priority_weight = 2,
        comparators = {
          cmp_rust.deprioritize_postfix,
          cmp_rust.deprioritize_borrow,
          cmp_rust.deprioritize_deref,
          cmp_rust.deprioritize_common_traits,
        }
      }
    })
  end,
  opts = function(_, opts)
    local cmp = require "cmp"
    local cmp_buffer = require "cmp_buffer"
    local compare = require "cmp.config.compare"
    local luasnip = require "luasnip"
    opts.sources = cmp.config.sources {
      { name = "nvim_lsp", priority = 1000 },
      { name = "luasnip", priority = 750 },
      { name = "buffer",
        priority = 500,
        option = {
          get_bufnrs = function()
            local bufs = {}
            for _, win in ipairs(vim.api.nvim_list_wins()) do
              bufs[vim.api.nvim_win_get_buf(win)] = true
            end
            return vim.tbl_keys(bufs)
          end
        }
      },
      { name = "path", priority = 250 },
    }
    opts.sorting = {
      comparators = {
        function(...) return cmp_buffer:compare_locality(...) end,
        compare.locality,
        compare.recently_used,
        compare.score,
        compare.offset,
        compare.order,
      }
    }
    return require("astronvim.utils").extend_tbl(opts, {
      completion = { completeopt = "menu,menuone,noinsert" },
      window = { documentation = { max_width = 40 } },
      mapping = {
        ["<C-p>"] = cmp.mapping.select_prev_item {
          behavior = cmp.SelectBehavior.Select,
        },
        ["<C-n>"] = cmp.mapping.select_next_item {
          behavior = cmp.SelectBehavior.Select,
        },
        ["<C-k>"] = cmp.mapping.select_prev_item {
          behavior = cmp.SelectBehavior.Select,
        },
        ["<C-j>"] = cmp.mapping.select_next_item {
          behavior = cmp.SelectBehavior.Select,
        },
        ["<Tab>"] = cmp.mapping(function(fallback)
          if luasnip.jumpable(1) then
            luasnip.jump(1)
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      },
    })
  end,
}
