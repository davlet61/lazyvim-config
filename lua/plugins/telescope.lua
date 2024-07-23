return {
  "nvim-telescope/telescope.nvim",
  opts = {
    defaults = {
      prompt_prefix = "   ",
      sorting_strategy = "ascending",
      layout_strategy = "horizontal", -- Ensure the layout is horizontal
      layout_config = {
        horizontal = {
          prompt_position = "top", -- Set the prompt to the top
          preview_width = 0.55, -- Adjust the preview width as needed
          results_width = 0.4, -- Adjust the results width accordingly
        },
        width = 0.87,
        height = 0.80,
        preview_cutoff = 120,
      },
    },
    -- extensions = {
    --   ["ui-select"] = {
    --     require("telescope.themes").get_dropdown({}),
    --   },
    -- },
  },
  keys = {
    -- disable the keymap to grep files
    { "<leader>/", false },
    { "<leader> ", false },
    -- change a keymap
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
    {
      "<leader>fw",
      function() require("telescope.builtin").live_grep {} end,
      desc = "Find Files",
    },
    -- add a keymap to browse plugin files
    {
      "<leader>fp",
      function() require("telescope.builtin").find_files { cwd = require("lazy.core.config").options.root } end,
      desc = "Find Plugin File",
    },
  },
}
