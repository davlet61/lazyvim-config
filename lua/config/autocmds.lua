-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Simple function to get highlight groups
local function get_hlgroup(name)
  local hl = vim.api.nvim_get_hl(0, { name = name })

  return {
    fg = hl.fg and string.format("#%06x", hl.fg) or nil,
    bg = hl.bg and string.format("#%06x", hl.bg) or nil,
  }
end

local function setup_telescope_highlights()
  local normal = get_hlgroup "Normal"
  local fg, bg = normal.fg, normal.bg
  local green = get_hlgroup("String").fg
  local red = get_hlgroup("Error").fg
  local float_bg = "#171717"
  local bg_alt = "#404040"

  local highlights = {
    TelescopeBorder = { fg = bg_alt, bg = float_bg },
    TelescopeNormal = { bg = float_bg },
    TelescopePreviewBorder = { fg = float_bg, bg = float_bg },
    TelescopePreviewNormal = { bg = float_bg },
    TelescopePreviewTitle = { fg = bg, bg = green },
    TelescopePromptBorder = { fg = bg_alt, bg = bg_alt },
    TelescopePromptNormal = { fg = fg, bg = bg_alt },
    TelescopePromptPrefix = { fg = red, bg = bg_alt },
    TelescopePromptTitle = { fg = float_bg, bg = red },
    TelescopeResultsBorder = { fg = float_bg, bg = float_bg },
    TelescopeResultsNormal = { bg = float_bg },
    TelescopeResultsTitle = { fg = float_bg, bg = float_bg },
  }

  for group, colors in pairs(highlights) do
    vim.api.nvim_set_hl(0, group, colors)
  end
end

-- Set up an autocmd to apply these highlights when a colorscheme changes
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = setup_telescope_highlights,
})

-- Also call the function immediately to apply the highlights on startup
setup_telescope_highlights()

-- Send filetype to title (for Wezterm)
vim.api.nvim_create_autocmd({ "BufEnter", "FileType" }, {
  callback = function()
    local filetype = vim.bo.filetype
    -- List of filetypes to ignore
    local ignore_filetypes = {
      "noice",
      "notify",
      "notifier",
      "TelescopePrompt",
      "lazy",
      "mason",
      "help",
      "qf",
      "NvimTree",
      "snacks_notif",
      "snacks_win_backdrop",
      -- "TelescopeResults",
      "",
    }
    for _, ignored in ipairs(ignore_filetypes) do
      if filetype == ignored then return end
    end
    vim.opt.title = true
    vim.opt.titlestring = filetype
    -- Snacks.notifier.notify("FileType => " .. filetype, "info")
  end,
})

local function normalize_path(path)
  local cwd = vim.fn.getcwd()
  -- Convert both paths to absolute paths and normalize them
  local abs_path = vim.fn.fnamemodify(path, ":p")
  local abs_cwd = vim.fn.fnamemodify(cwd, ":p")

  -- Remove trailing slash from cwd if it exists
  abs_cwd = abs_cwd:gsub("/$", "")

  local relative_path = abs_path:gsub("^" .. vim.pesc(abs_cwd) .. "/?", "")
  return relative_path
end

local function add_all_buffers_to_harpoon()
  local harpoon = require "harpoon"

  -- Get list of all buffers
  local buffers = vim.api.nvim_list_bufs()

  for _, buf in ipairs(buffers) do
    -- Check if buffer is loaded and valid
    if vim.api.nvim_buf_is_loaded(buf) and vim.api.nvim_buf_is_valid(buf) then
      local bufname = vim.api.nvim_buf_get_name(buf)
      -- Only add if it's a real file and not a harpoon UI buffer
      if bufname and bufname ~= "" and not string.match(bufname, "harpoon") then harpoon:list():add() end
    end
  end
end

-- Create autocmd to remove deleted buffers from harpoon
vim.api.nvim_create_autocmd("BufDelete", {
  callback = function(ev)
    local harpoon = require "harpoon"
    local bufname = vim.api.nvim_buf_get_name(ev.buf)

    if bufname and bufname ~= "" and not string.match(bufname, "harpoon") then
      local normalized_bufname = normalize_path(bufname)
      local list = harpoon:list()
      local items = list:display()
      for idx, item in ipairs(items) do
        if item == normalized_bufname then
          local item_to_remove = list:get(idx)
          list:remove(item_to_remove)
          break
        end
      end
    end
  end,
})

-- Create a command to call the add function
vim.api.nvim_create_user_command("HarpoonAddAll", add_all_buffers_to_harpoon, {})

-- Auto-add new buffers to harpoon
vim.api.nvim_create_autocmd({ "BufNew", "BufAdd" }, {
  callback = function(ev)
    local harpoon = require "harpoon"
    local bufname = vim.api.nvim_buf_get_name(ev.buf)

    vim.schedule(function()
      if
        -- vim.api.nvim_buf_is_valid(ev.buf)
        bufname
        and bufname ~= ""
        and not string.match(bufname, "harpoon")
        and vim.api.nvim_get_option_value("buftype", { buf = ev.buf }) ~= "terminal"
      then
        harpoon:list():add()
      end
    end)
  end,
})
