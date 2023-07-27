return {
  "windwp/nvim-autopairs",
  config = function(plugin, opts)
    -- run default AstroNvim config
    require "plugins.configs.nvim-autopairs"(plugin, opts)

    --
    -- nvim-cmp integration
    --
    local cmp, cmp_ok = pcall(require, "cmp")
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    local ts_utils, ts_utils_ok = pcall(require, "nvim-treesitter.ts_utils")

    if cmp_ok and ts_utils_ok then
      local ts_node_func_parens_disabled = {
        -- ecma
        named_imports = true,
        -- rust
        use_declaration = true,
      }

      local default_handler = cmp_autopairs.filetypes["*"]["("].handler
      cmp_autopairs.filetypes["*"]["("].handler = function(char, item, bufnr, rules, commit_character)
        local node_type = ts_utils.get_node_at_cursor():type()
        if ts_node_func_parens_disabled[node_type] then
          if item.data then
            item.data.funcParensDisabled = true
          else
            char = ""
          end
        end
        default_handler(char, item, bufnr, rules, commit_character)
      end

      cmp.event:on(
        "confirm_done",
        cmp_autopairs.on_confirm_done({
          sh = false,
        })
      )
    end

    --
    -- Autopair rules
    --
    local npairs = require "nvim-autopairs"
    local Rule = require "nvim-autopairs.rule"
    local cond = require "nvim-autopairs.conds"

    -- Add spaces between parentheses
    local brackets = { { '(', ')' }, { '[', ']' }, { '{', '}' } }
    npairs.add_rules {
      Rule(' ', ' ')
        :with_pair(function(_opts)
          local pair = _opts.line:sub(_opts.col -1, _opts.col)
          return vim.tbl_contains({
            brackets[1][1]..brackets[1][2],
            brackets[2][1]..brackets[2][2],
            brackets[3][1]..brackets[3][2]
          }, pair)
        end)
        :with_move(cond.none())
        :with_cr(cond.none())
        :with_del(function(_opts)
          local col = vim.api.nvim_win_get_cursor(0)[2]
          local context = _opts.line:sub(col - 1, col + 2)
          return vim.tbl_contains({
            brackets[1][1]..'  '..brackets[1][2],
            brackets[2][1]..'  '..brackets[2][2],
            brackets[3][1]..'  '..brackets[3][2]
          }, context)
        end)
    }
    for _,bracket in pairs(brackets) do
      Rule('', ' '..bracket[2])
        :with_pair(cond.none())
        :with_move(function(_opts) return _opts.char == bracket[2] end)
        :with_cr(cond.none())
        :with_del(cond.none())
        :use_key(bracket[2])
    end

    -- Move past commas and semicolons
    for _,punct in pairs { ",", ";" } do
      npairs.add_rules {
        require "nvim-autopairs.rule"("", punct)
          :with_move(function(_opts) return _opts.char == punct end)
          :with_pair(function() return false end)
          :with_del(function() return false end)
          :with_cr(function() return false end)
          :use_key(punct)
      }
    end

    -- Add arrow operator expansion for JavaScript
    Rule('%(.*%)%s*%=>$', ' {  }', { 'typescript', 'typescriptreact', 'javascript' })
      :use_regex(true)
      :set_end_pair_length(2)

    -- Add space after =
    Rule('=', '')
      :with_pair(cond.not_inside_quote())
      :with_pair(function(_opts)
        local last_char = _opts.line:sub(_opts.col - 1, _opts.col - 1)
        if last_char:match('[%w%=%s]') then
          return true
        end
        return false
      end)
      :replace_endpair(function(_opts)
        local prev_2char = _opts.line:sub(_opts.col - 2, _opts.col - 1)
        local next_char = _opts.line:sub(_opts.col, _opts.col)
        next_char = next_char == ' ' and '' or ' '
        if prev_2char:match('%w$') then
          return '<bs> =' .. next_char
        end
        if prev_2char:match('%=$') then
          return next_char
        end
        if prev_2char:match('=') then
          return '<bs><bs>=' .. next_char
        end
        ret:meurn ''
      end)
      :set_end_pair_length(0)
      :with_move(cond.none())
      :with_del(cond.none())

    -- Dynamically add pair after text starts
    npairs.add_rules({
      Rule("\\start(%w*) $", "tex")
        :replace_endpair(function(_opts)
          local beforeText = string.sub(_opts.line, 0, _opts.col)
          local _, _, match = beforeText:find("\\start(%w*)")
          if match and #match > 0 then
            return " \\stop" .. match
          end
          return ''
        end)
        :with_move(cond.none())
        :use_key("<space>")
        :use_regex(true)
    })
  end,
}
