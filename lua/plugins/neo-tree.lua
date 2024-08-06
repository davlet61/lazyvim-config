return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    close_if_last_window = true,
    enable_diagnostics = true,
    filesystem = {
      filtered_items = {
        visible = true,
        hide_dotfiles = false,
        hide_gitignored = true,
        hide_by_name = {
          ".git",
          ".DS_Store",
          "thumbs.db",
        },
      },
    },
    sort_case_insensitive = true,
    group_empty_dirs = true,
    window = {
      position = "right",
    },
    event_handlers = {
      {
        event = "neo_tree_buffer_enter",
        handler = function()
          vim.opt_local.cursorline = true
          vim.api.nvim_set_hl(0, "NeotreeCursorLine", { bg = "#2a3834" })
        end,
      },
    },
  },
}
