-- TypeScript-specific performance optimizations
---@type LazySpec
return {
  -- Optimize TypeScript syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- TypeScript-specific optimizations
      opts.highlight = opts.highlight or {}
      opts.highlight.disable = function(lang, buf)
        local max_filesize = 50 * 1024 -- 50 KB for TypeScript files
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize and (lang == "typescript" or lang == "tsx") then
          return true
        end
      end
    end,
  },
  
  -- Optimize vim settings for TypeScript
  {
    "AstroNvim/astrocore",
    opts = {
      autocmds = {
        typescript_optimizations = {
          {
            event = "FileType",
            pattern = { "typescript", "typescriptreact", "tsx" },
            callback = function()
              -- Reduce updatetime for better responsiveness
              vim.opt_local.updatetime = 300
              -- Optimize folding for large TypeScript files
              vim.opt_local.foldmethod = "manual"
              -- Disable some heavy features for TypeScript
              vim.b.ts_highlight_disable = true
            end,
          },
        },
      },
    },
  },
}