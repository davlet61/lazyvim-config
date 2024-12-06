local M = {}

M.state = {
  enabled = true,
  filename_buf = nil,
  filename_win = nil,
}

local function get_file_icon(filename)
  local has_devicons, devicons = pcall(require, "nvim-web-devicons")
  if has_devicons then
    local icon, icon_color = devicons.get_icon_color(filename, vim.fn.fnamemodify(filename, ":e"))
    if icon then return icon, icon_color end
  end
  return "", "#6d8086"
end

local function create_sticky_filename()
  if not M.state.enabled then return end

  local bufnr = vim.api.nvim_get_current_buf()
  local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufnr), ":t")
  if filename == "" then return end

  local icon, icon_color = get_file_icon(filename)
  local display_text = string.format("%s %s", icon, filename)
  local width = vim.fn.strdisplaywidth(display_text) + 2

  if not M.state.filename_buf then M.state.filename_buf = vim.api.nvim_create_buf(false, true) end

  local win_width = vim.api.nvim_win_get_width(0)

  local float_win_config = {
    relative = "editor",
    row = 0,
    col = win_width - width,
    width = width,
    height = 1,
    style = "minimal",
    focusable = false,
    zindex = 100,
    border = "none",
  }

  if not M.state.filename_win or not vim.api.nvim_win_is_valid(M.state.filename_win) then
    M.state.filename_win = vim.api.nvim_open_win(M.state.filename_buf, false, float_win_config)
    vim.api.nvim_set_option_value("winblend", 0, { win = M.state.filename_win })
    local hl_group = "FileInfo" .. bufnr
    vim.api.nvim_set_hl(0, hl_group, { fg = icon_color })
    vim.api.nvim_set_option_value("winhighlight", "Normal:" .. hl_group, { win = M.state.filename_win })
  else
    vim.api.nvim_win_set_config(M.state.filename_win, float_win_config)
  end

  vim.api.nvim_buf_set_lines(M.state.filename_buf, 0, -1, true, { display_text })
end

function M.toggle()
  M.state.enabled = not M.state.enabled
  if M.state.enabled then
    create_sticky_filename()
  else
    if M.state.filename_win and vim.api.nvim_win_is_valid(M.state.filename_win) then
      vim.api.nvim_win_close(M.state.filename_win, true)
      M.state.filename_win = nil
    end
    if M.state.filename_buf and vim.api.nvim_buf_is_valid(M.state.filename_buf) then
      vim.api.nvim_buf_delete(M.state.filename_buf, { force = true })
      M.state.filename_buf = nil
    end
  end
end

function M.setup(opts)
  opts = opts or {}
  M.state.enabled = opts.enabled ~= false

  local group = vim.api.nvim_create_augroup("StickyFilename", { clear = true })
  vim.api.nvim_create_autocmd({
    "BufEnter",
    "WinScrolled",
    "VimResized",
    "BufWritePost",
    "TextChanged",
    "TextChangedI",
  }, {
    group = group,
    callback = create_sticky_filename,
  })

  vim.schedule(create_sticky_filename)
end

return M
