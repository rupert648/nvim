return {
  -- Disable the built-in tsserver that might be loaded through Mason or other means
  {
    "williamboman/mason-lspconfig.nvim",
    opts = function(_, opts)
      -- Add servers to the exclusion list
      opts.ensure_installed = opts.ensure_installed or {}
      opts.skip_setup = opts.skip_setup or {}

      -- Add tsserver to the skip_setup list
      table.insert(opts.skip_setup, "tsserver")

      return opts
    end,
  },
}
