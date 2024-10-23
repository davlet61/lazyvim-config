return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
  },
  config = function(_, opts)
    local cmp = require "cmp"
    local luasnip = require "luasnip"

    -- SQL file types setup
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "sql", "mysql", "plsql" },
      callback = function()
        cmp.setup.buffer {
          sources = {
            { name = "vim-dadbod-completion" },
            { name = "buffer" },
          },
        }
      end,
    })

    -- Configure completion behavior
    opts.mapping = opts.mapping or {}
    opts.mapping = vim.tbl_extend("force", opts.mapping, {
      ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Select },
      ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select },
      ["<C-k>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Select },
      ["<C-j>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select },
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.confirm { select = true }
        elseif luasnip.expandable() then
          luasnip.expand()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { "i", "s" }),
    })

    -- Configure sources and other options
    opts = vim.tbl_deep_extend("force", opts, {
      sources = cmp.config.sources {
        { name = "codeium", priority = 1200 }, -- Highest priority for Codeium
        { name = "nvim_lsp", priority = 1000 },
        { name = "luasnip", priority = 750 },
        { name = "buffer", priority = 500 },
        { name = "path", priority = 250 },
      },
      preselect = cmp.PreselectMode.None,
      completion = {
        completeopt = "menu,menuone,noinsert,noselect",
      },
    })

    cmp.setup(opts)
  end,
}
-- return {
--   "hrsh7th/nvim-cmp",
--   dependencies = {
--     { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
--   },
--   config = function(_, opts)
--     local cmp = require("cmp")
--
--     -- Set up sources for SQL file types
--     vim.api.nvim_create_autocmd("FileType", {
--       pattern = { "sql", "mysql", "plsql" },
--       callback = function()
--         cmp.setup.buffer({
--           sources = {
--             { name = "vim-dadbod-completion" },
--             { name = "buffer" },
--           },
--         })
--       end,
--     })
--
--     opts.mapping["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select })
--     opts.mapping["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select })
--     opts.mapping["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select })
--     opts.mapping["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select })
--     opts.mapping["<Tab>"] = { i = cmp.config.disable, c = cmp.config.disable }
--     cmp.setup(opts)
--   end,
-- }
