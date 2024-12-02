if vim.g.colors_name ~= nil then vim.cmd("highlight clear") end
vim.g.colors_name = "smol"
local hi = vim.api.nvim_set_hl
local dummy_fg = "#2563eb"
local dummy_bg = "#fecdd3"
local dummy_sp = "#2dd4bf"

local bg_0 = "#ffffff"
local bg_1 = "#f6f8fa"
local bg_2 = "#e6eaef"
local fg_0 = "#1f2328"
local select = "#0969da"

hi(0, "SpecialKey", { fg = dummy_fg })
hi(0, "TermCursor", { reverse = true })
hi(0, "NonText", { fg = dummy_fg })
hi(0, "Directory", { fg = dummy_fg })
hi(0, "ErrorMsg", { fg = dummy_fg })
hi(0, "Search", { fg = dummy_fg, bg = dummy_bg })
hi(0, "CurSearch", { fg = dummy_fg, bg = dummy_bg })
hi(0, "MoreMsg", { fg = dummy_fg })
hi(0, "ModeMsg", { fg = dummy_fg })
hi(0, "LineNr", { fg = dummy_fg })
hi(0, "CursorLineNr", { bold = true })
hi(0, "Question", { fg = dummy_fg })
hi(0, "StatusLine", { fg = dummy_fg, bg = dummy_bg })
hi(0, "StatusLineNC", { fg = dummy_fg, bg = dummy_bg })
hi(0, "Title", { bold = true, fg = dummy_fg })
hi(0, "Visual", { bg = dummy_bg })
hi(0, "WarningMsg", { fg = dummy_fg })
hi(0, "Folded", { fg = dummy_fg, bg = dummy_bg })
hi(0, "DiffAdd", { fg = dummy_fg, bg = dummy_bg })
hi(0, "DiffChange", { fg = dummy_fg, bg = dummy_bg })
hi(0, "DiffDelete", { bold = true, fg = dummy_fg })
hi(0, "DiffText", { fg = dummy_fg, bg = dummy_bg })
hi(0, "SignColumn", { fg = dummy_fg })
hi(0, "Conceal", { fg = dummy_fg })
hi(0, "SpellBad", { undercurl = true, sp = dummy_sp })
hi(0, "SpellCap", { undercurl = true, sp = dummy_sp })
hi(0, "SpellRare", { undercurl = true, sp = dummy_sp })
hi(0, "SpellLocal", { undercurl = true, sp = dummy_sp })
hi(0, "Pmenu", { bg = dummy_bg })
hi(0, "PmenuSel", { fg = dummy_fg, bg = dummy_bg, blend = 0 })
hi(0, "PmenuThumb", { bg = dummy_bg })
hi(0, "TabLineSel", { bold = true })
hi(0, "CursorColumn", { bg = dummy_bg })
hi(0, "CursorLine", { bg = dummy_bg })
hi(0, "ColorColumn", { bg = dummy_bg })
hi(0, "QuickFixLine", { fg = dummy_fg })
hi(0, "NormalFloat", { bg = dummy_bg })
hi(0, "WinBar", { bold = true, fg = dummy_fg, bg = dummy_bg })
hi(0, "WinBarNC", { fg = dummy_fg, bg = dummy_bg })
hi(0, "Cursor", { fg = dummy_bg, bg = dummy_fg })
hi(0, "RedrawDebugNormal", { reverse = true })
hi(0, "Underlined", { underline = true })
hi(0, "lCursor", { fg = dummy_bg, bg = dummy_fg })
hi(0, "Normal", { fg = dummy_fg, bg = dummy_bg })
hi(0, "Constant", { fg = dummy_fg })
hi(0, "Statement", { bold = true, fg = dummy_fg })
hi(0, "PreProc", { fg = dummy_fg })
hi(0, "Type", { fg = dummy_fg })
hi(0, "Special", { fg = dummy_fg })
hi(0, "DiagnosticError", { fg = dummy_fg })
hi(0, "DiagnosticWarn", { fg = dummy_fg })
hi(0, "DiagnosticInfo", { fg = dummy_fg })
hi(0, "DiagnosticHint", { fg = dummy_fg })
hi(0, "DiagnosticOk", { fg = dummy_fg })
hi(0, "Comment", { fg = dummy_fg })
hi(0, "@variable", { fg = dummy_fg })
hi(0, "String", { fg = dummy_fg })
hi(0, "Identifier", { fg = dummy_fg })
hi(0, "Function", { fg = dummy_fg })
hi(0, "Operator", { fg = dummy_fg })
hi(0, "Delimiter", { fg = dummy_fg })
hi(0, "Todo", { bold = true, fg = dummy_fg })
hi(0, "@markup.strong", { bold = true })
hi(0, "@markup.italic", { italic = true })
hi(0, "@markup.strikethrough", { strikethrough = true })
hi(0, "@markup.underline", { underline = true })
hi(0, "Added", { fg = dummy_fg })
hi(0, "Removed", { fg = dummy_fg })
hi(0, "Changed", { fg = dummy_fg })
hi(0, "DiagnosticDeprecated", { strikethrough = true, sp = dummy_sp })
hi(0, "FloatShadow", { bg = dummy_bg, blend = 80 })
hi(0, "FloatShadowThrough", { bg = dummy_bg, blend = 100 })
hi(0, "MatchParen", { bold = true, bg = dummy_bg })
hi(0, "RedrawDebugClear", { bg = dummy_bg })
hi(0, "RedrawDebugComposed", { bg = dummy_bg })
hi(0, "RedrawDebugRecompose", { bg = dummy_bg })
hi(0, "Error", { fg = dummy_fg, bg = dummy_bg })
hi(0, "DiagnosticUnderlineError", { underline = true, sp = dummy_sp })
hi(0, "DiagnosticUnderlineWarn", { underline = true, sp = dummy_sp })
hi(0, "DiagnosticUnderlineInfo", { underline = true, sp = dummy_sp })
hi(0, "DiagnosticUnderlineHint", { underline = true, sp = dummy_sp })
hi(0, "DiagnosticUnderlineOk", { underline = true, sp = dummy_sp })
hi(0, "NvimInternalError", { fg = dummy_fg, bg = dummy_fg })
