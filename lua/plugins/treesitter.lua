-- Customize Treesitter

---@type LazySpec
return {
  { "mustache/vim-mustache-handlebars", ft = { "mustache", "handlebars", "hbs" } },
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    -- add more things to the ensure_installed table protecting against community packs modifying it
    opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
      "lua",
      "vim",
      "typescript",
      "javascript",
      "tsx",
      "json",
      "html",
      "css",
      -- add more arguments for adding more treesitter parsers
    })
    
    -- Performance optimizations
    opts.highlight = opts.highlight or {}
    opts.highlight.additional_vim_regex_highlighting = false
    opts.highlight.disable = function(lang, buf)
      local max_filesize = 100 * 1024 -- 100 KB
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
        return true
      end
    end
    
    -- Reduce incremental_selection for better performance
    opts.incremental_selection = {
      enable = false,
    }
  end,
}
