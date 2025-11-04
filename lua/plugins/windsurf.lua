return {
  "Exafunction/windsurf.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
  },
  config = function()
    -- giveme a comment now pls :(
    require("codeium").setup {
      virtual_text = {
        enabled = true,
        key_bindings = {
          accept = "<C-y>",
          next = "<M-]>",
          prev = "<M-[>",
        },
      },
      enable_chat = true,
    }
    vim.keymap.set("n", "<leader>cc", ":Codeium Chat<CR>", { desc = "Open Codeium Chat" })
  end,
}
