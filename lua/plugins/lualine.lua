return {
  -- {
  --   "christopher-francisco/tmux-status.nvim",
  --   lazy = true,
  --   opts = {},
  -- },
  { "nvim-lualine/lualine.nvim", opts = function(_, opts) table.remove(opts.sections.lualine_z) end },
}
