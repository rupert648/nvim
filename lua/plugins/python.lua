return {
  -- Better Python support with virtual environment detection
  {
    "linux-cultist/venv-selector.nvim",
    branch = "regexp",
    cmd = "VenvSelect",
    opts = {
      settings = {
        options = {
          notify_user_on_venv_activation = true,
        },
      },
    },
    ft = "python",
    keys = { { "<leader>cv", "<cmd>VenvSelect<cr>", desc = "Select VirtualEnv", ft = "python" } },
  },
  
  -- Enhanced Python LSP with automatic venv detection
  {
    "AstroNvim/astrolsp",
    optional = true,
    ---@type AstroLSPOpts
    opts = {
      config = {
        basedpyright = {
          on_new_config = function(config, root_dir)
            -- Auto-detect virtual environment
            local util = require "lspconfig.util"
            local path = util.path
            
            -- Priority order: uv .venv, then other common patterns
            local venv_paths = {
              path.join(root_dir, ".venv", "bin", "python"),
              path.join(root_dir, ".venv", "Scripts", "python.exe"),
              path.join(root_dir, "venv", "bin", "python"),
              path.join(root_dir, "venv", "Scripts", "python.exe"),
              path.join(root_dir, ".conda", "bin", "python"),
              path.join(root_dir, "env", "bin", "python"),
            }
            
            for _, python_path in ipairs(venv_paths) do
              if vim.fn.executable(python_path) == 1 then
                config.settings = vim.tbl_deep_extend("force", config.settings or {}, {
                  python = {
                    pythonPath = python_path,
                    analysis = {
                      extraPaths = { path.join(root_dir, ".venv", "lib") },
                    },
                  },
                })
                break
              end
            end
          end,
          settings = {
            python = {
              analysis = {
                autoImportCompletions = true,
                typeCheckingMode = "standard",
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                indexing = true,
                packageIndexDepths = {
                  {
                    name = "",
                    depth = 2,
                  },
                },
              },
            },
            basedpyright = {
              disableOrganizeImports = true,
            },
          },
        },
      },
    },
  },
  
  -- Python formatter and linter
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        python = { "ruff_format", "ruff_fix" },
      },
      formatters = {
        ruff_format = {
          command = "ruff",
          args = { "format", "--stdin-filename", "$FILENAME", "-" },
          stdin = true,
        },
        ruff_fix = {
          command = "ruff",
          args = { "check", "--fix", "--stdin-filename", "$FILENAME", "-" },
          stdin = true,
        },
      },
    },
  },
}