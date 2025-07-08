return {
  "sindrets/diffview.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  cmd = { "DiffviewOpen", "DiffviewFileHistory" },
  keys = {
    { "<leader>dv", "<cmd>DiffviewOpen<cr>", desc = "Open Diffview" },
    { "<leader>dh", "<cmd>DiffviewFileHistory<cr>", desc = "Open File History" },
    { "<leader>dc", "<cmd>DiffviewClose<cr>", desc = "Close Diffview" },
  },
  opts = {
    keymaps = {
      view = {
        -- In diff view:
        ["<tab>"] = "select_next_entry", -- Open the diff for the next file
        ["<s-tab>"] = "select_prev_entry", -- Open the diff for the previous file
        ["<leader>e"] = "focus_files", -- Bring focus to the file panel
        ["<leader>b"] = "toggle_files", -- Toggle the file panel
      },
      file_panel = {
        ["j"] = "next_entry", -- Bring the cursor to the next file entry
        ["k"] = "prev_entry", -- Bring the cursor to the previous file entry
        ["<cr>"] = "select_entry", -- Open the diff for the selected entry
        ["s"] = "stage_entry", -- Stage the selected entry
        ["u"] = "unstage_entry", -- Unstage the selected entry
        ["<c-u>"] = "toggle_stage_entry", -- Toggle staged state for selected entry
        ["R"] = "refresh_files", -- Update stats and entries in the file list
      },
    },
  },
}
