return {
  "jay-babu/mason-nvim-dap.nvim",
  opts = {
    ensure_installed = {
      "bash", "codelldb", "coreclr", "delve", "elixir", "haskell", "javadbg",
      "javatest", "js", "php", "python",
    },
    handlers = {
      python = function(_)
        local dap = require "dap"
        dap.configurations.python = {
          {
            type = "python",
            request = "launch",
            name = "Launch file",
            program = "${file}", -- This configuration will launch the current file if used.
            pythonPath = function()
              -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
              -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
              -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.

              local venv = os.getenv("VIRTUAL_ENV")
              if venv and venv ~= "" then
                if vim.fn.executable(venv .. "/python") == 1 then
                  return venv .. "/python3"
                elseif vim.fn.executable(venv .. "/python") then
                  return venv .. "/python"
                end
              end

              local cwd = vim.fn.getcwd()
              if vim.fn.executable(cwd .. "/venv/bin/python3") == 1 then
                return cwd .. "/venv/bin/python3"
              elseif vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
                return cwd .. "/venv/bin/python"
              elseif vim.fn.executable(cwd .. "/.venv/bin/python3") == 1 then
                return cwd .. "/.venv/bin/python3"
              elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
                return cwd .. "/.venv/bin/python"
              elseif vim.fn.executable("python3") then
                return "python3"
              elseif vim.fn.executable("python") then
                return "python"
              else
                return nil
              end
            end,
          },
        }
      end,
    },
  },
}
