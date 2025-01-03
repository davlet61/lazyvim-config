return {
  "ibhagwan/fzf-lua",
  cmd = "FzfLua",
  config = function(_, opts)
    if opts[1] == "default-title" then
      -- use the same prompt for all pickers for profile `default-title` and
      -- profiles that use `default-title` as base profile
      local function fix(t)
        t.prompt = t.prompt ~= nil and "   " or nil
        for _, v in pairs(t) do
          if type(v) == "table" then fix(v) end
        end
        return t
      end
      opts = vim.tbl_deep_extend("force", fix(require "fzf-lua.profiles.default-title"), opts)
      opts[1] = nil
    end
    require("fzf-lua").setup(opts)
  end,
  keys = {
    { "<leader>sw", false },
    { "<leader>sw", mode = "v", false },
    {
      "<leader>sw",
      function()
        if vim.fn.mode() == "v" or vim.fn.mode() == "V" then
          LazyVim.pick "grep_visual"()
        else
          LazyVim.pick "grep_cword"()
        end
      end,
      desc = "Word/Selection (Root Dir)",
      mode = { "n", "v" },
    },
  },
}
