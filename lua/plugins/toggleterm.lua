return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("toggleterm").setup {
        shade_terminals = false,
        -- shading_factor = -30,
        -- shading_ratio = -3,
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
            local toggle = function() t:toggle() end
            for _, key in ipairs { "<C-'>", "<F7>" } do
              vim.keymap.set({ "n", "t", "i" }, key, toggle, { desc = "Toggle terminal", buffer = t.bufnr })
            end
          end
        end,
        direction = "float",
        float_opts = { border = "rounded" },
      }

      --- Merge extended options with a default table of options
      ---@param default? table The default table that you want to merge into
      ---@param opts? table The new options that should be merged with the default table
      ---@return table # The merged table
      local function extend_tbl(default, opts)
        opts = opts or {}
        return default and vim.tbl_deep_extend("force", default, opts) or opts
      end

      -- Toggle a user terminal if it exists, if not then create a new one and save it
      ---@param opts string|table A terminal command string or a table of options for Terminal:new() (Check toggleterm.nvim documentation for table format)
      local function toggle_term_cmd(opts)
        local terms = {}
        -- if a command string is provided, create a basic table for Terminal:new() options
        if type(opts) == "string" then opts = { cmd = opts } end
        opts = extend_tbl({ hidden = true }, opts)
        local num = vim.v.count > 0 and vim.v.count or 1
        -- if terminal doesn't exist yet, create it
        if not terms[opts.cmd] then terms[opts.cmd] = {} end
        if not terms[opts.cmd][num] then
          if not opts.count then opts.count = vim.tbl_count(terms) * 100 + num end
          local on_exit = opts.on_exit
          opts.on_exit = function(...)
            terms[opts.cmd][num] = nil
            if on_exit then on_exit(...) end
          end
          terms[opts.cmd][num] = require("toggleterm.terminal").Terminal:new(opts)
        end
        -- toggle the terminal
        terms[opts.cmd][num]:toggle()
      end

      vim.keymap.set("t", "<Esc><Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })
      vim.keymap.set(
        "t",
        "<Esc>q",
        '<C-\\><C-n><cmd>lua require("toggleterm").toggle()<CR>',
        { desc = "Toggle terminal mode" }
      )

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
      vim.keymap.set(
        "n",
        "<leader>td",
        function() toggle_term_cmd "lazydocker" end,
        { desc = "Docker (terminal)", noremap = true, silent = true }
      )
      vim.keymap.set(
        "n",
        "<leader>ts",
        function() toggle_term_cmd "spf ." end,
        { desc = "Toggle (superfile)", noremap = true, silent = true }
      )
      -- vim.defer_fn(
      --   function()
      --     vim.keymap.set(
      --       "n",
      --       "<leader>gg",
      --       toggle_lazygit,
      --       { desc = "LazyGit (toggleterm)", noremap = true, silent = true }
      --     )
      --   end,
      --   10
      -- )
      -- vim.api.nvim_create_autocmd("User", {
      --   pattern = "VeryLazy",
      --   callback = function()
      --     vim.keymap.set(
      --       "n",
      --       "<leader>gg",
      --       toggle_lazygit,
      --       { desc = "LazyGit (terminal)", noremap = true, silent = true }
      --     )
      --   end,
      -- })
      -- vim.keymap.set("n", "<leader>gg", toggle_lazygit, { desc = "LazyGit (terminal)", noremap = true, silent = true })
    end,
  },
}
