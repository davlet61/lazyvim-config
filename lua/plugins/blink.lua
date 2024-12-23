return {
  "saghen/blink.cmp",
  version = not vim.g.lazyvim_blink_main and "*",
  opts = {
    keymap = {
      preset = "enter",
      ["<Tab>"] = { "select_and_accept" },
    },
  },
}
