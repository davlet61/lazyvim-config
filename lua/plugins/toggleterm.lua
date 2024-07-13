return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        shade_terminals = true,
        highlights = {
          Normal = { link = "Normal" },
          NormalNC = { link = "NormalNC" },
          NormalFloat = { link = "NormalFloat" },
          FloatBorder = { link = "FloatBorder" },
          StatusLine = { link = "StatusLine" },
          StatusLineNC = { link = "StatusLineNC" },
          WinBar = { link = "WinBar" },
          WinBarNC = { link = "WinBarNC" },
        },
        size = 10,
        ---@param t Terminal
        on_create = function(t)
          vim.opt_local.foldcolumn = "0"
          vim.opt_local.signcolumn = "no"
          if t.hidden then
            local toggle = function()
              t:toggle()
            end
            for _, key in ipairs({ "<C-'>", "<F7>" }) do
              vim.keymap.set({ "n", "t", "i" }, key, toggle, { desc = "Toggle terminal", buffer = t.bufnr })
            end
          end
        end,
        shading_factor = 2,
        direction = "float",
        float_opts = { border = "rounded" },
      })

      vim.keymap.set(
        "n",
        "<Leader>th",
        "<Cmd>ToggleTerm size=15 direction=horizontal<CR>",
        { desc = "Terminal (horizontal)" }
      )
      vim.keymap.set(
        "n",
        "<Leader>tv",
        "<Cmd>ToggleTerm size=80 direction=vertical<CR>",
        { desc = "Terminal (vertical)" }
      )
      vim.keymap.set(
        "n",
        "<leader>tf",
        "<cmd>ToggleTerm direction=float<cr>",
        { desc = "Terminal (float)", noremap = true, silent = true }
      )
    end,
  },
}
