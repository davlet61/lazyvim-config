return {
  dir = vim.fn.stdpath "config" .. "/lua/sticky-filename",
  lazy = false,
  keys = {
    { "<leader>uW", function() require("sticky-filename").toggle() end, desc = "(Toggle) sticky filename" },
  },
  config = function()
    require("sticky-filename").setup {
      enabled = true,
    }
  end,
}
