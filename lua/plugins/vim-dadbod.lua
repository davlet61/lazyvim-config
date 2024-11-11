return {
  "kristijanhusak/vim-dadbod-ui",
  dependencies = {
    { "tpope/vim-dadbod", lazy = true },
    -- { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
  },

  init = function()
    vim.g.db_ui_use_nerd_fonts = 1
    vim.g.db_ui_win_position = "right"
    vim.g.db = "postgresql://postgres:postgres@localhost:5437/whitson-pvt"
  end,
}
