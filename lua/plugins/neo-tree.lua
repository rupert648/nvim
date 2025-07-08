return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    filesystem = {
      filtered_items = {
        visible = true,
        show_hidden_count = true,
        hide_dotfiles = false,
        hide_gitignored = true,
        hide_by_name = {
          -- '.git',
          -- '.DS_Store',
          -- 'thumbs.db',
        },
        never_show = {},
      },
      -- Performance optimizations
      use_libuv_file_watcher = true,
      scan_mode = "shallow",
      async_directory_scan = "always",
    },
    event_handlers = {
      {
        event = "neo_tree_buffer_enter",
        handler = function()
          -- Disable syntax highlighting in neo-tree for performance
          vim.opt_local.syntax = "off"
        end,
      },
    },
  },
}
