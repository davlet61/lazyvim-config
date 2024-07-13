-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set
local del = vim.keymap.del

-- Delete defaults
del("n", "<leader>qq")
del("n", "<leader>ft")
del("n", "<leader>fT")
del("n", "<leader>ww")
del("n", "<leader>wd")
del("n", "<leader>wm")
del("n", "<leader>w-")
del("n", "<leader>w|")
del("n", "<leader>-")
del("n", "<leader>|")
del("n", "<leader><Space>")
del("n", "<leader>sw")
del("n", "<leader>qs")
del("n", "<leader>ql")
del("n", "<leader>qd")

map("n", "<leader>q", "<Cmd>confirm q<CR>", { desc = "Quit Window" })
map("n", "<leader>Q", "<Cmd>confirm qall<CR>", { desc = "Quit all" })
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save" })
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- Windows
map("n", "<leader>pw", "<C-W>p", { desc = "Other window", remap = true })
map("n", "<leader>pd", "<C-W>c", { desc = "Delete Window", remap = true })
map("n", "<leader>p-", "<C-W>s", { desc = "Split window below", remap = true })
map("n", "<leader>ph", "<C-W>s", { desc = "Split window (horizontal)", remap = true })
map("n", "<leader>pv", "<C-W>v", { desc = "Split window (vertical)", remap = true })
map("n", "<leader>p+", "<C-W>v", { desc = "Split window right", remap = true })
map("n", "<leader>-", "<C-W>s", { desc = "Split window below", remap = true })
map("n", "<leader>|", "<C-W>v", { desc = "Split window right", remap = true })
map("n", "<leader>+", "<C-W>v", { desc = "Split window right", remap = true })
map("n", "<leader>pm", function()
  LazyVim.toggle.maximize()
end, { desc = "Maximize Toggle" })

-- Spectre
map("n", "<leader>ss", function()
  require("spectre").open()
end, { desc = "Spectre (search)" })

map("n", "<leader>sf", function()
  require("spectre").open_file_search()
end, { desc = "Spectre (current file)" })

map("n", "<leader>sw", function()
  require("spectre").open_visual({ select_word = true })
end, { desc = "Spectre (current word)" })

-- Sessions
map("n", "<leader>Ss", function()
  require("persistence").load()
end, { desc = "Restore Session" })
map("n", "<leader>Sl", function()
  require("persistence").load({ last = true })
end, { desc = "Restore Last Session" })
map("n", "<leader>Sd", function()
  require("persistence").stop()
end, { desc = "Don't Save Current Session" })
