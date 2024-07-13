-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set
local del = vim.keymap.del

-- Delete defaults
del("n", "<leader>ft")
del("n", "<leader>fT")
del("n", "<leader>ww")
del("n", "<leader>wd")
del("n", "<leader>wm")
del("n", "<leader>w-")
del("n", "<leader>w|")
del("n", "<leader>-")
del("n", "<leader>|")

map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save" })
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- windows
map("n", "<leader>pw", "<C-W>p", { desc = "Other window", remap = true })
map("n", "<leader>pd", "<C-W>c", { desc = "Delete Window", remap = true })
map("n", "<leader>p-", "<C-W>s", { desc = "Split window below", remap = true })
map("n", "<leader>p|", "<C-W>v", { desc = "Split window right", remap = true })
map("n", "<leader>p+", "<C-W>v", { desc = "Split window right", remap = true })
map("n", "<leader>-", "<C-W>s", { desc = "Split window below", remap = true })
map("n", "<leader>|", "<C-W>v", { desc = "Split window right", remap = true })
map("n", "<leader>+", "<C-W>v", { desc = "Split window right", remap = true })
map("n", "<leader>pm", function()
  LazyVim.toggle.maximize()
end, { desc = "Maximize Toggle" })
