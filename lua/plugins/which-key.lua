return {
  "folke/which-key.nvim",
  opts = {
    spec = {
      {
        mode = { "n", "v" },
        { "<leader>w", desc = "", hidden = true },
        { "<leader>q", desc = "", hidden = true },
        { "<leader>p", group = "windows" },
        { "<leader>S", group = "Sessions" },
        { "<leader>t", group = "Terminal" },
      },
    },
  },
}
