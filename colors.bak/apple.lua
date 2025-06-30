if vim.g.colors_name ~= nil then vim.cmd("highlight clear") end
vim.g.colors_name = "apple"
local hi = vim.api.nvim_set_hl

local bg_normal = "#ffffff"
local bg_pmenu = "#f4f4f4"
local bg_search_pmenuthumb = "#e5e5e5"

local bg_cursorcolumn_cursorline_cursorlinenr = "#ecf5ff"
local bg_visual = "#b4d8fd"

local bg_diffadd = "#edfff0"
local bg_diffdelete = "#fef0f1"
local bg_difftext = "#fdfae6"

local bg_incsearch_matchparen = "#fef869"
local bg_sel = "#156adf"

local fg_char_number = "#272ad8"
local fg_comment = "#8a99a6"
local fg_conceal_linenr_nontext = "#cdcdcd"
local fg_delimiter_operator = "#5c6873"
local fg_directory_link_function_identifier_def = "#0f68a0"
local fg_function_constant = "#804fb8"
local fg_gitsigns_all = "#34537e"
local fg_identifier = "#3e8087"
local fg_normal = "#262626"
local fg_preproc_warningmsg = "#78492a"
local fg_signify = "#69a7fc"
local fg_special = "#23575c"
local fg_statement_prompt = "#ad3da4"
local fg_string_errormsg = "#d12f1b"
local fg_type = "#4b21b0"
local fg_typedef = "#0b4f79"

hi(0, "Added", { fg = "#ffff00", bg = "#ff0000" })
hi(0, "Changed", { fg = "#ffff00", bg = "#ff0000" })
hi(0, "NormalNC", { fg = "#ffff00", bg = "#ff0000" })
hi(0, "MsgArea", { fg = "#ffff00", bg = "#ff0000" })
hi(0, "@diff", { fg = "#ffff00", bg = "#ff0000" })
hi(0, "@lsp", { fg = "#ffff00", bg = "#ff0000" })
hi(0, "TermCursorNC", { fg = "#ffff00", bg = "#ff0000" })
hi(0, "ColorColumn", { fg = "#ffff00", bg = "#ff0000" })
hi(0, "Cursor", { fg = "#ffff00", bg = "#ff0000" })
hi(0, "DiagnosticDeprecated", { fg = "#ffff00", bg = "#ff0000" })
hi(0, "DiagnosticOk", { fg = "#ffff00", bg = "#ff0000" })
hi(0, "DiagnosticUnderlineOk", { fg = "#ffff00", bg = "#ff0000" })
hi(0, "FloatShadow", { fg = "#ffff00", bg = "#ff0000" })
hi(0, "FloatShadowThrough", { fg = "#ffff00", bg = "#ff0000" })
hi(0, "NvimInternalError", { fg = "#ffff00", bg = "#ff0000" })
hi(0, "RedrawDebugClear", { fg = "#ffff00", bg = "#ff0000" })
hi(0, "RedrawDebugComposed", { fg = "#ffff00", bg = "#ff0000" })
hi(0, "RedrawDebugNormal", { fg = "#ffff00", bg = "#ff0000" })
hi(0, "RedrawDebugRecompose", { fg = "#ffff00", bg = "#ff0000" })
hi(0, "Removed", { fg = "#ffff00", bg = "#ff0000" })
hi(0, "SpellBad", { fg = "#ffff00", bg = "#ff0000" })
hi(0, "SpellCap", { fg = "#ffff00", bg = "#ff0000" })
hi(0, "SpellLocal", { fg = "#ffff00", bg = "#ff0000" })
hi(0, "SpellRare", { fg = "#ffff00", bg = "#ff0000" })
hi(0, "StatusLine", { fg = "#ffff00", bg = "#ff0000" })
hi(0, "StatusLineNC", { fg = "#ffff00", bg = "#ff0000" })
hi(0, "TabLineSel", { fg = "#ffff00", bg = "#ff0000" })
hi(0, "TermCursor", { fg = "#ffff00", bg = "#ff0000" })
hi(0, "VisualNC", { fg = "#ffff00", bg = "#ff0000" })
hi(0, "WinBar", { fg = "#ffff00", bg = "#ff0000" })
hi(0, "WinBarNC", { fg = "#ffff00", bg = "#ff0000" })
hi(0, "lCursor", { fg = "#ffff00", bg = "#ff0000" })

hi(0, "Normal", { fg = fg_normal, bg = bg_normal })
hi(0, "Comment", { fg = fg_comment })
hi(0, "Statement", { fg = fg_statement_prompt })
hi(0, "Function", { fg = fg_function_constant, bold = true })
hi(0, "Delimiter", { fg = fg_delimiter_operator })
hi(0, "@variable", { fg = fg_normal })
hi(0, "HlArgs", { italic = true })
hi(0, "@variable.member", { fg = fg_identifier })
hi(0, "Type", { fg = fg_type })
hi(0, "Special", { fg = fg_type })
hi(0, "@markup.italic", { italic = true })
hi(0, "@markup.strikethrough", { strikethrough = true })
hi(0, "@markup.strong", { bold = true })
hi(0, "@markup.underline", { underline = true })
hi(0, "Conceal", { fg = fg_conceal_linenr_nontext })
hi(0, "Constant", { fg = fg_function_constant })
hi(0, "CurSearch", { fg = bg_normal, bg = fg_preproc_warningmsg })
hi(0, "CursorColumn", { bg = bg_cursorcolumn_cursorline_cursorlinenr })
hi(0, "CursorLine", { bg = bg_cursorcolumn_cursorline_cursorlinenr })
hi(0, "CursorLineNr", { bg = bg_cursorcolumn_cursorline_cursorlinenr, fg = fg_normal })
hi(0, "DiagnosticError", { fg = fg_string_errormsg })
hi(0, "DiagnosticHint", { fg = fg_delimiter_operator })
hi(0, "DiagnosticInfo", { fg = fg_statement_prompt })
hi(0, "DiagnosticWarn", { fg = fg_preproc_warningmsg })
hi(0, "DiagnosticUnderlineError", { fg = fg_string_errormsg })
hi(0, "DiagnosticUnderlineHint", { fg = fg_delimiter_operator })
hi(0, "DiagnosticUnderlineInfo", { fg = fg_statement_prompt })
hi(0, "DiagnosticUnderlineWarn", { fg = fg_preproc_warningmsg })
hi(0, "DiffAdd", { bg = bg_diffadd })
hi(0, "DiffChange", { bg = bg_diffadd })
hi(0, "DiffDelete", { bg = bg_diffdelete })
hi(0, "DiffText", { bg = bg_difftext })
hi(0, "Directory", { fg_directory_link_function_identifier_def })
hi(0, "Error", { fg = bg_normal, bg = fg_string_errormsg })
hi(0, "ErrorMsg", { fg = fg_string_errormsg })
hi(0, "Folded", { fg = fg_comment, bg = bg_search_pmenuthumb })
hi(0, "Identifier", { fg = fg_identifier })
hi(0, "LineNr", { fg = fg_conceal_linenr_nontext })
hi(0, "MatchParen", { bg = bg_incsearch_matchparen, fg = fg_normal })
hi(0, "ModeMsg", { fg = fg_comment })
hi(0, "MoreMsg", { fg = fg_statement_prompt })
hi(0, "NonText", { fg = fg_conceal_linenr_nontext })
hi(0, "NormalFloat", { bg = bg_pmenu })
hi(0, "Operator", { fg = fg_delimiter_operator })
hi(0, "Pmenu", { bg = bg_pmenu, fg = fg_normal })
hi(0, "PmenuSel", { bg = bg_sel, blend = 0, fg = bg_normal })
hi(0, "PmenuThumb", { bg = bg_search_pmenuthumb, fg = bg_search_pmenuthumb })
hi(0, "PreProc", { fg = fg_preproc_warningmsg })
hi(0, "Question", { ctermfg = 6, fg = fg_statement_prompt })
hi(0, "QuickFixLine", { bg = bg_sel, ctermfg = 6, fg = bg_normal })
hi(0, "Search", { bg = bg_search_pmenuthumb, ctermbg = 3, ctermfg = 15, fg = fg_normal })
hi(0, "SignColumn", { fg = fg_conceal_linenr_nontext })
hi(0, "SpecialKey", { fg = fg_conceal_linenr_nontext })
hi(0, "String", { ctermfg = 2, fg = fg_string_errormsg })
hi(0, "Title", { bold = true, fg = fg_normal })
hi(0, "Todo", { bold = true, fg = fg_delimiter_operator })
hi(0, "Underlined", { fg = fg_directory_link_function_identifier_def, underline = true })
hi(0, "Visual", { bg = bg_visual, ctermbg = 0, ctermfg = 15 })
hi(0, "WarningMsg", { ctermfg = 3, fg = fg_preproc_warningmsg })
