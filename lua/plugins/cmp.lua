return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
  },
  config = function(_, opts)
    local cmp = require("cmp")

    -- Set up sources for SQL file types
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "sql", "mysql", "plsql" },
      callback = function()
        cmp.setup.buffer({
          sources = {
            { name = "vim-dadbod-completion" },
            { name = "buffer" },
          },
        })
      end,
    })

    opts.mapping["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select })
    opts.mapping["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select })
    opts.mapping["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select })
    opts.mapping["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select })
    opts.mapping["<Tab>"] = { i = cmp.config.disable, c = cmp.config.disable }
    cmp.setup(opts)
  end,
}
