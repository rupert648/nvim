-- AstroLSP allows you to customize the features in AstroNvim's LSP configuration engine
-- Configuration documentation can be found with `:h astrolsp`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
    -- Configuration table of features provided by AstroLSP
    features = {
      autoformat = true, -- enable or disable auto formatting on start
      codelens = false, -- disable codelens refresh for better performance
      inlay_hints = false, -- enable/disable inlay hints on start
      semantic_tokens = false, -- disable semantic tokens for better performance
    },
    -- customize lsp formatting options
    formatting = {
      -- control auto formatting on save
      format_on_save = {
        enabled = true, -- enable or disable format on save globally
        allow_filetypes = { -- enable format on save for specified filetypes only
          -- "go",
        },
        ignore_filetypes = { -- disable format on save for specified filetypes
          -- "python",
        },
      },
      disabled = { -- disable formatting capabilities for the listed language servers
        -- disable lua_ls formatting capability if you want to use StyLua to format your lua code
        -- "lua_ls",
      },
      timeout_ms = 500, -- reduce format timeout for better performance
      -- filter = function(client) -- fully override the default formatting function
      --   return true
      -- end
    },
    -- enable servers that you already have installed without mason
    servers = {
      "gleam",
      "basedpyright",
    },
    -- customize language server configuration options passed to `lspconfig`
    ---@diagnostic disable: missing-fields
    config = {
      -- clangd = { capabilities = { offsetEncoding = "utf-8" } },
      basedpyright = {
        before_init = function(_, config)
          -- Find the Python executable in the project's virtual environment
          local util = require "lspconfig.util"
          local path = util.path
          
          -- Look for uv .venv first, then fallback to other venv patterns
          local venv_paths = {
            path.join(config.root_dir, ".venv", "bin", "python"),
            path.join(config.root_dir, ".venv", "Scripts", "python.exe"),
            path.join(config.root_dir, "venv", "bin", "python"),
            path.join(config.root_dir, "venv", "Scripts", "python.exe"),
          }
          
          for _, venv_python in ipairs(venv_paths) do
            if vim.fn.executable(venv_python) == 1 then
              config.settings.python.pythonPath = venv_python
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
              stubPath = vim.fn.stdpath("data") .. "/lazy/python-type-stubs",
            },
          },
        },
      },
    },
    -- customize how language servers are attached
    handlers = {
      -- a function without a key is simply the default handler, functions take two parameters, the server name and the configured options table for that server
      -- function(server, opts) require("lspconfig")[server].setup(opts) end

      -- the key is the server that is being setup with `lspconfig`
      -- Disable the TypeScript language server
      tsserver = false, -- setting a handler to false will disable the set up of that language server
      -- pyright = function(_, opts) require("lspconfig").pyright.setup(opts) end -- or a custom handler function can be passed
    },
    -- Configure buffer local auto commands to add when attaching a language server
    autocmds = {
      -- Disable document highlighting autocmds for better performance
      -- Uncomment below if you want document highlighting back
      -- lsp_document_highlight = {
      --   cond = "textDocument/documentHighlight",
      --   {
      --     event = { "CursorHold", "CursorHoldI" },
      --     desc = "Document Highlighting",
      --     callback = function() vim.lsp.buf.document_highlight() end,
      --   },
      --   {
      --     event = { "CursorMoved", "CursorMovedI", "BufLeave" },
      --     desc = "Document Highlighting Clear",
      --     callback = function() vim.lsp.buf.clear_references() end,
      --   },
      -- },
    },
    -- mappings to be set up on attaching of a language server
    mappings = {
      n = {
        gl = { function() vim.diagnostic.open_float() end, desc = "Hover diagnostics" },
        -- a `cond` key can provided as the string of a server capability to be required to attach, or a function with `client` and `bufnr` parameters from the `on_attach` that returns a boolean
        -- gD = {
        --   function() vim.lsp.buf.declaration() end,
        --   desc = "Declaration of current symbol",
        --   cond = "textDocument/declaration",
        -- },
        -- ["<Leader>uY"] = {
        --   function() require("astrolsp.toggles").buffer_semantic_tokens() end,
        --   desc = "Toggle LSP semantic highlight (buffer)",
        --   cond = function(client) return client.server_capabilities.semanticTokensProvider and vim.lsp.semantic_tokens end,
        -- },
      },
    },
    -- A custom `on_attach` function to be run after the default `on_attach` function
    -- takes two parameters `client` and `bufnr`  (`:h lspconfig-setup`)
    on_attach = function(client, bufnr)
      -- this would disable semanticTokensProvider for all clients
      -- client.server_capabilities.semanticTokensProvider = nil
    end,
  },
}
