-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Simple function to get highlight groups
local function get_hlgroup(name)
  local ok, hl = pcall(vim.api.nvim_get_hl_by_name, name, true)
  if not ok then
    return {}
  end
  return {
    fg = hl.foreground and string.format("#%06x", hl.foreground) or nil,
    bg = hl.background and string.format("#%06x", hl.background) or nil,
  }
end

local function setup_telescope_highlights()
  local normal = get_hlgroup("Normal")
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
