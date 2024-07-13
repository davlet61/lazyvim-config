return {
  "vuki656/package-info.nvim",
  event = "BufRead package.json",
  dependencies = { "MunifTanjim/nui.nvim" },
  config = function()
    local package_info = require("package-info")

    vim.keymap.set(
      { "n" },
      "<LEADER>ns",
      package_info.show,
      { silent = true, noremap = true, desc = "Show dependency versions" }
    )
    vim.keymap.set(
      { "n" },
      "<LEADER>nc",
      package_info.hide,
      { silent = true, noremap = true, desc = "Hide dependency versions" }
    )
    vim.keymap.set(
      { "n" },
      "<LEADER>nt",
      package_info.toggle,
      { silent = true, noremap = true, desc = "Toggle dependency versions" }
    )
    vim.keymap.set(
      { "n" },
      "<LEADER>nu",
      package_info.update,
      { silent = true, noremap = true, desc = "Update dependency on the line" }
    )
    vim.keymap.set(
      { "n" },
      "<LEADER>nd",
      package_info.delete,
      { silent = true, noremap = true, desc = "Delete dependency on the line" }
    )
    vim.keymap.set(
      { "n" },
      "<LEADER>ni",
      package_info.install,
      { silent = true, noremap = true, desc = "Install a new dependency" }
    )
    vim.keymap.set(
      { "n" },
      "<LEADER>np",
      package_info.change_version,
      { silent = true, noremap = true, desc = "Install a different dependency version" }
    )

    return package_info.setup({
      colors = {
        up_to_date = "#3C4048", -- Text color for up to date dependency virtual text
        outdated = "#d19a66", -- Text color for outdated dependency virtual text
      },
      hide_up_to_date = true,
    })
  end,
}
