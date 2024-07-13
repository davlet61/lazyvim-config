return {
  "mg979/vim-visual-multi",
  event = "LazyFile",
  config = function()
    vim.g.VM_theme = "ocean"
    -- vim-visual-multi keymaps
    vim.g.VM_maps = {
      ["Add Cursor Up"] = "<C-k>",
      ["Add Cursor Down"] = "<C-j>",
    }

    -- vim.g.VM_highlight_matches = ''
    -- vim.g.VM_Mono_hl   = 'DiffText'
    -- vim.g.VM_Extend_hl = 'DiffAdd'
    -- vim.g.VM_Cursor_hl = 'Visual'
    -- vim.g.VM_Insert_hl = 'DiffChange'
  end,
}
