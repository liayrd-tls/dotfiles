-- ~/.config/lvim/lua/user/colorscheme/custom_rider.lua

local colors = {
    bg       = "#1e1e2e",
    fg       = "#cdd6f4",
    red      = "#f38ba8",
    green    = "#a6e3a1",
    yellow   = "#f9e2af",
    blue     = "#89b4fa",
    magenta  = "#cba6f7",
    cyan     = "#94e2d5",
    gray     = "#6c7086",
  }
  
  vim.cmd("highlight clear")
  vim.opt.background = "dark"
  vim.g.colors_name = "custom_rider"
  
  -- Основні кольори
  vim.api.nvim_set_hl(0, "Normal",        { fg = colors.fg, bg = colors.bg })
  vim.api.nvim_set_hl(0, "Comment",       { fg = colors.gray, italic = true })
  vim.api.nvim_set_hl(0, "Identifier",    { fg = colors.blue })
  vim.api.nvim_set_hl(0, "Statement",     { fg = colors.magenta, bold = true })
  vim.api.nvim_set_hl(0, "PreProc",       { fg = colors.yellow })
  vim.api.nvim_set_hl(0, "Type",          { fg = colors.green })
  vim.api.nvim_set_hl(0, "String",        { fg = colors.green })
  vim.api.nvim_set_hl(0, "Number",        { fg = colors.cyan })
  vim.api.nvim_set_hl(0, "Function",      { fg = colors.green })
  vim.api.nvim_set_hl(0, "Visual",        { bg = colors.gray })
  vim.api.nvim_set_hl(0, "LineNr",        { fg = colors.gray })
  vim.api.nvim_set_hl(0, "CursorLineNr",  { fg = colors.yellow, bold = true })
  -- Додайте інші групи за потребою
  
