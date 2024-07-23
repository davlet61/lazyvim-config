-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set
local nomap = vim.keymap.del

-- Delete defaults
nomap("n", "<leader>qq")
nomap("n", "<leader>ft")
nomap("n", "<leader>fT")
-- nomap("n", "<leader>ww")
-- nomap("n", "<leader>wd")
-- nomap("n", "<leader>wm")
-- nomap("n", "<leader>w-")
-- nomap("n", "<leader>w|")
nomap("n", "<leader>-")
nomap("n", "<leader>|")
-- nomap("n", "<leader><Space>")
nomap("n", "<leader>sw")
nomap("n", "<leader>qs")
nomap("n", "<leader>ql")
nomap("n", "<leader>qd")

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
map("n", "<leader>pm", function() LazyVim.toggle.maximize() end, { desc = "Maximize Toggle" })

-- Sessions
map("n", "<leader>Ss", function() require("persistence").load() end, { desc = "Restore Session" })
map("n", "<leader>Sl", function() require("persistence").load { last = true } end, { desc = "Restore Last Session" })
map("n", "<leader>Sd", function() require("persistence").stop() end, { desc = "Don't Save Current Session" })

-- Nvim Ufo
map("n", "zR", function() require("ufo").openAllFolds() end, { desc = "Open all folds" })
map("n", "zM", function() require("ufo").closeAllFolds() end, { desc = "Close all folds" })
map("n", "zr", function() require("ufo").openFoldsExceptKinds() end, { desc = "Fold less" })
map("n", "zm", function() require("ufo").closeFoldsWith() end, { desc = "Fold more" })
map("n", "zp", function() require("ufo").peekFoldedLinesUnderCursor() end, { desc = "Peek fold" })
