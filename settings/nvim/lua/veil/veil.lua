local c = require("veil.palette.julia")

vim.api.nvim_set_hl(0, "Normal", { bg = c.bg, fg = c.white })
vim.api.nvim_set_hl(0, "NormalNC", { bg = c.bg })
vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = c.bg })

vim.api.nvim_set_hl(0, "DiagnosticError", { fg = c.red })
vim.api.nvim_set_hl(0, "DiagnosticWarn", { fg = c.yellow })
vim.api.nvim_set_hl(0, "DiagnosticInfo", { fg = c.blue })
vim.api.nvim_set_hl(0, "DiagnosticHint", { fg = c.green })

vim.api.nvim_set_hl(0, "Comment", { fg = c.blue })
vim.api.nvim_set_hl(0, "String", { fg = c.green })
vim.api.nvim_set_hl(0, "Function", { fg = c.yellow })
vim.api.nvim_set_hl(0, "Keyword", { fg = c.red })
vim.api.nvim_set_hl(0, "Number", { fg = c.yellow })
vim.api.nvim_set_hl(0, "Type", { fg = c.green })
vim.api.nvim_set_hl(0, "Constant", { fg = c.blue })
vim.api.nvim_set_hl(0, "Statement", { fg = c.red })
vim.api.nvim_set_hl(0, "PreProc", { fg = c.blue })

vim.api.nvim_set_hl(0, "LineNr", { fg = c.white, bg = c.bg })
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = c.yellow, bold = true })
vim.api.nvim_set_hl(0, "CursorLine", { bg = c.bg, blend = 95 })

vim.api.nvim_set_hl(0, "Search", { bg = c.yellow, fg = c.bg })
vim.api.nvim_set_hl(0, "IncSearch", { bg = c.blue, fg = c.bg })

vim.api.nvim_set_hl(0, "StatusLine", { bg = c.bg, fg = c.white })
vim.api.nvim_set_hl(0, "StatusLineNC", { bg = c.bg, fg = c.blue })

vim.api.nvim_set_hl(0, "Visual", { bg = c.blue, fg = c.bg })

vim.api.nvim_set_hl(0, "Pmenu", { bg = c.bg, fg = c.white })
vim.api.nvim_set_hl(0, "PmenuSel", { bg = c.blue, fg = c.bg })
vim.api.nvim_set_hl(0, "PmenuThumb", { bg = c.white })

vim.api.nvim_set_hl(0, "TabLine", { bg = c.bg, fg = c.blue })
vim.api.nvim_set_hl(0, "TabLineSel", { bg = c.blue, fg = c.bg, bold = true })
vim.api.nvim_set_hl(0, "TabLineFill", { bg = c.bg })

vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = c.green })
vim.api.nvim_set_hl(0, "GitSignsChange", { fg = c.yellow })
vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = c.red })
