-- Made with 'mini.colors' module of https://github.com/echasnovski/mini.nvim

if vim.g.colors_name ~= nil then vim.cmd('highlight clear') end
vim.g.colors_name = "tokyonight-day"

-- Highlight groups
local hi = vim.api.nvim_set_hl

hi(0, "@HlargsNamedParams", { link = "Hlargs" })
hi(0, "@HlargsNamedParams.python", { fg = "#8d95ba" })
hi(0, "@annotation", { link = "PreProc" })
hi(0, "@attribute", { link = "PreProc" })
hi(0, "@character.printf", { link = "SpecialChar" })
hi(0, "@character.special", { link = "SpecialChar" })
hi(0, "@comment.documentation", { fg = "#828bb2" })
hi(0, "@comment.error", { fg = "#c95353" })
hi(0, "@comment.hint", { fg = "#1d6a5c" })
hi(0, "@comment.info", { fg = "#196775" })
hi(0, "@comment.note", { fg = "#1d6a5c" })
hi(0, "@comment.todo", { fg = "#3062a7" })
hi(0, "@comment.warning", { fg = "#645137" })
hi(0, "@constant.builtin", { fg = "#7a4817" })
hi(0, "@constant.macro", { link = "Define" })
hi(0, "@constructor", { link = "Type" })
hi(0, "@constructor.tsx", { fg = "#205f6a" })
hi(0, "@controlFlow", { link = "Conditional" })
hi(0, "@diff.delta", { link = "DiffChange" })
hi(0, "@diff.minus", { link = "DiffDelete" })
hi(0, "@diff.plus", { link = "DiffAdd" })
hi(0, "@exception", { link = "Conditional" })
hi(0, "@formatSpecifier", { link = "@punctuation.bracket" })
hi(0, "@function.builtin", { bold = true, fg = "#2d5b9e" })
hi(0, "@function.call", { link = "@function" })
hi(0, "@function.macro", { link = "Macro" })
hi(0, "@function.method", { link = "Function" })
hi(0, "@function.method.call", { link = "@function.method" })
hi(0, "@keyword", { fg = "#8357c1" })
hi(0, "@keyword.conditional", { link = "Conditional" })
hi(0, "@keyword.coroutine", { link = "@keyword" })
hi(0, "@keyword.debug", { link = "Debug" })
hi(0, "@keyword.directive", { link = "PreProc" })
hi(0, "@keyword.directive.define", { link = "Define" })
hi(0, "@keyword.exception", { link = "Exception" })
hi(0, "@keyword.function", { link = "@keyword" })
hi(0, "@keyword.import", { link = "@keyword" })
hi(0, "@keyword.operator", { link = "@operator" })
hi(0, "@keyword.repeat", { link = "Repeat" })
hi(0, "@keyword.return", { link = "Conditional" })
hi(0, "@keyword.storage", { link = "StorageClass" })
hi(0, "@label", { link = "@variable.member" })
hi(0, "@lsp.type.boolean", { link = "@boolean" })
hi(0, "@lsp.type.builtinType", { link = "@type.builtin" })
hi(0, "@lsp.type.comment", { link = "@comment" })
hi(0, "@lsp.type.decorator", { link = "@attribute" })
hi(0, "@lsp.type.deriveHelper", { link = "@attribute" })
hi(0, "@lsp.type.enum", { link = "@type" })
hi(0, "@lsp.type.enumMember", { link = "@constant" })
hi(0, "@lsp.type.escapeSequence", { link = "@string.escape" })
hi(0, "@lsp.type.formatSpecifier", { link = "@markup.list" })
hi(0, "@lsp.type.generic", { link = "@variable" })
hi(0, "@lsp.type.interface", { fg = "#1e526a" })
hi(0, "@lsp.type.interface.typescript", { link = "Type" })
hi(0, "@lsp.type.keyword", { link = "@keyword" })
hi(0, "@lsp.type.lifetime", { link = "@keyword.storage" })
hi(0, "@lsp.type.namespace", { link = "@module" })
hi(0, "@lsp.type.namespace.python", { link = "@variable" })
hi(0, "@lsp.type.number", { link = "@number" })
hi(0, "@lsp.type.operator", { link = "@operator" })
hi(0, "@lsp.type.parameter", { link = "@variable.parameter" })
hi(0, "@lsp.type.property", { link = "@property" })
hi(0, "@lsp.type.selfKeyword", { link = "@variable.builtin" })
hi(0, "@lsp.type.selfTypeKeyword", { link = "@variable.builtin" })
hi(0, "@lsp.type.string", { link = "@string" })
hi(0, "@lsp.type.typeAlias", { link = "@type.definition" })
hi(0, "@lsp.type.unresolvedReference", { sp = "#c95353", undercurl = true })
hi(0, "@lsp.type.variable", {})
hi(0, "@lsp.typemod.class.defaultLibrary", { link = "@type.builtin" })
hi(0, "@lsp.typemod.enum.defaultLibrary", { link = "@type.builtin" })
hi(0, "@lsp.typemod.enumMember.defaultLibrary", { link = "@constant.builtin" })
hi(0, "@lsp.typemod.function.defaultLibrary", { link = "@function.builtin" })
hi(0, "@lsp.typemod.keyword.async", { link = "@keyword.coroutine" })
hi(0, "@lsp.typemod.keyword.injected", { link = "@keyword" })
hi(0, "@lsp.typemod.macro.defaultLibrary", { link = "@function.builtin" })
hi(0, "@lsp.typemod.method.defaultLibrary", { link = "@function.builtin" })
hi(0, "@lsp.typemod.operator.injected", { link = "@operator" })
hi(0, "@lsp.typemod.string.injected", { link = "@string" })
hi(0, "@lsp.typemod.struct.defaultLibrary", { link = "@type.builtin" })
hi(0, "@lsp.typemod.type.defaultLibrary", { fg = "#477983" })
hi(0, "@lsp.typemod.typeAlias.defaultLibrary", { fg = "#477983" })
hi(0, "@lsp.typemod.variable.callable", { link = "@function" })
hi(0, "@lsp.typemod.variable.defaultLibrary", { link = "@variable.builtin" })
hi(0, "@lsp.typemod.variable.injected", { link = "@variable" })
hi(0, "@lsp.typemod.variable.static", { link = "@constant" })
hi(0, "@markup", { link = "@none" })
hi(0, "@markup.emphasis", { italic = true })
hi(0, "@markup.environment", { link = "Macro" })
hi(0, "@markup.environment.name", { link = "Type" })
hi(0, "@markup.heading", { link = "Title" })
hi(0, "@markup.heading.1.markdown", { bold = true, fg = "#1c54a0" })
hi(0, "@markup.heading.2.markdown", { bold = true, fg = "#564124" })
hi(0, "@markup.heading.3.markdown", { bold = true, fg = "#32441f" })
hi(0, "@markup.heading.4.markdown", { bold = true, fg = "#075d4c" })
hi(0, "@markup.heading.5.markdown", { bold = true, fg = "#6d20bc" })
hi(0, "@markup.heading.6.markdown", { bold = true, fg = "#7847bd" })
hi(0, "@markup.link", { fg = "#1d6a5c" })
hi(0, "@markup.link.label", { link = "@markup.link.url" })
hi(0, "@markup.link.label.symbol", { link = "Identifier" })
hi(0, "@markup.link.url", { link = "Underlined" })
hi(0, "@markup.list", { fg = "#164754" })
hi(0, "@markup.list.checked", { fg = "#304e4a" })
hi(0, "@markup.list.markdown", { link = "@punctuation.bracket" })
hi(0, "@markup.list.unchecked", { fg = "#3062a7" })
hi(0, "@markup.math", { link = "Special" })
hi(0, "@markup.raw", { link = "String" })
hi(0, "@markup.raw.block.markdown", {})
hi(0, "@markup.raw.markdown_inline", { bg = "#a7acc8", fg = "#3062a7" })
hi(0, "@module", { link = "Include" })
hi(0, "@module.builtin", { fg = "#b12e54" })
hi(0, "@namespace.builtin", { link = "@variable.builtin" })
hi(0, "@number.float", { link = "Float" })
hi(0, "@operator", { fg = "#2e4477" })
hi(0, "@property", { link = "@variable.member" })
hi(0, "@punctuation.bracket", { fg = "#828bb2" })
hi(0, "@punctuation.delimiter", { fg = "#7681aa" })
hi(0, "@punctuation.special", { link = "@punctuation.bracket" })
hi(0, "@string.documentation", { fg = "#828bb2" })
hi(0, "@string.escape", { fg = "#7933c0" })
hi(0, "@string.regexp", { link = "Constant" })
hi(0, "@tag", { link = "Label" })
hi(0, "@tag.attribute", { link = "@property" })
hi(0, "@tag.delimiter", { link = "@punctuation.bracket" })
hi(0, "@tag.delimiter.tsx", { fg = "#6588ba" })
hi(0, "@tag.javascript", { fg = "#b12e54" })
hi(0, "@tag.tsx", { fg = "#b12e54" })
hi(0, "@type.builtin", { fg = "#38737d" })
hi(0, "@type.definition", { link = "Typedef" })
hi(0, "@type.qualifier", { link = "@keyword" })
hi(0, "@variable", { fg = "#2e4477" })
hi(0, "@variable.builtin", { fg = "#b12e54", italic = true })
hi(0, "@variable.member", { fg = "#196775" })
hi(0, "@variable.parameter", { italic = true })
hi(0, "@variable.parameter.builtin", { fg = "#554b41" })
hi(0, "Bold", { bold = true, fg = "#2e4477" })
hi(0, "Character", { fg = "#445433" })
hi(0, "CmpDocumentation", { bg = "#cdd0db", fg = "#2e4477" })
hi(0, "CmpDocumentationBorder", { bg = "#cdd0db", fg = "#477983" })
hi(0, "CmpGhostText", { fg = "#a7acc8" })
hi(0, "CmpItemAbbr", { fg = "#2e4477" })
hi(0, "CmpItemAbbrDefault", { fg = "#2e4477" })
hi(0, "CmpItemAbbrDeprecated", { fg = "#aeb3ce", strikethrough = true })
hi(0, "CmpItemAbbrDeprecatedDefault", { fg = "#8d95ba" })
hi(0, "CmpItemAbbrMatch", { bold = true, fg = "#3062a7" })
hi(0, "CmpItemAbbrMatchDefault", { fg = "#2e4477" })
hi(0, "CmpItemAbbrMatchFuzzy", { link = "CmpItemAbbrMatch" })
hi(0, "CmpItemAbbrMatchFuzzyDefault", { fg = "#2e4477" })
hi(0, "CmpItemKindArray", { link = "LspKindArray" })
hi(0, "CmpItemKindBoolean", { link = "LspKindBoolean" })
hi(0, "CmpItemKindClass", { link = "LspKindClass" })
hi(0, "CmpItemKindClassDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindCodeium", { fg = "#1d6a5c" })
hi(0, "CmpItemKindColor", { link = "LspKindColor" })
hi(0, "CmpItemKindColorDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindConstant", { link = "LspKindConstant" })
hi(0, "CmpItemKindConstantDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindConstructor", { link = "LspKindConstructor" })
hi(0, "CmpItemKindConstructorDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindCopilot", { fg = "#1d6a5c" })
hi(0, "CmpItemKindDefault", { fg = "#205f6a" })
hi(0, "CmpItemKindEnum", { link = "LspKindEnum" })
hi(0, "CmpItemKindEnumDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindEnumMember", { link = "LspKindEnumMember" })
hi(0, "CmpItemKindEnumMemberDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindEvent", { link = "LspKindEvent" })
hi(0, "CmpItemKindEventDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindField", { link = "LspKindField" })
hi(0, "CmpItemKindFieldDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindFile", { link = "LspKindFile" })
hi(0, "CmpItemKindFileDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindFolder", { link = "LspKindFolder" })
hi(0, "CmpItemKindFolderDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindFunction", { link = "LspKindFunction" })
hi(0, "CmpItemKindFunctionDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindInterface", { link = "LspKindInterface" })
hi(0, "CmpItemKindInterfaceDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindKey", { link = "LspKindKey" })
hi(0, "CmpItemKindKeyword", { link = "LspKindKeyword" })
hi(0, "CmpItemKindKeywordDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindMethod", { link = "LspKindMethod" })
hi(0, "CmpItemKindMethodDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindModule", { link = "LspKindModule" })
hi(0, "CmpItemKindModuleDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindNamespace", { link = "LspKindNamespace" })
hi(0, "CmpItemKindNull", { link = "LspKindNull" })
hi(0, "CmpItemKindNumber", { link = "LspKindNumber" })
hi(0, "CmpItemKindObject", { link = "LspKindObject" })
hi(0, "CmpItemKindOperator", { link = "LspKindOperator" })
hi(0, "CmpItemKindOperatorDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindPackage", { link = "LspKindPackage" })
hi(0, "CmpItemKindProperty", { link = "LspKindProperty" })
hi(0, "CmpItemKindPropertyDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindReference", { link = "LspKindReference" })
hi(0, "CmpItemKindReferenceDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindSnippet", { link = "LspKindSnippet" })
hi(0, "CmpItemKindSnippetDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindString", { link = "LspKindString" })
hi(0, "CmpItemKindStruct", { link = "LspKindStruct" })
hi(0, "CmpItemKindStructDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindSupermaven", { fg = "#1d6a5c" })
hi(0, "CmpItemKindTabNine", { fg = "#1d6a5c" })
hi(0, "CmpItemKindText", { link = "LspKindText" })
hi(0, "CmpItemKindTextDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindTypeParameter", { link = "LspKindTypeParameter" })
hi(0, "CmpItemKindTypeParameterDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindUnit", { link = "LspKindUnit" })
hi(0, "CmpItemKindUnitDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindValue", { link = "LspKindValue" })
hi(0, "CmpItemKindValueDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindVariable", { link = "LspKindVariable" })
hi(0, "CmpItemKindVariableDefault", { link = "CmpItemKind" })
hi(0, "CmpItemMenu", { fg = "#8d95ba" })
hi(0, "CmpItemMenuDefault", { fg = "#2e4477" })
hi(0, "ColorColumn", { bg = "#d7d9e1" })
hi(0, "Comment", { fg = "#8d95ba" })
hi(0, "Conceal", { fg = "#747ba2" })
hi(0, "Conditional", { fg = "#8357c1", italic = true })
hi(0, "Constant", { fg = "#7a4817" })
hi(0, "CurSearch", { link = "IncSearch" })
hi(0, "Cursor", { bg = "#2e4477", fg = "#e1e2e7" })
hi(0, "CursorColumn", { bg = "#d3d5e1" })
hi(0, "CursorIM", { bg = "#2e4477", fg = "#e1e2e7" })
hi(0, "CursorLine", { bg = "#d3d5e1" })
hi(0, "CursorLineCurrent", { bg = "#c4c8da" })
hi(0, "CursorLineNr", { bg = "#d7d9e1", fg = "#747ba2" })
hi(0, "DapStoppedLine", { bg = "#d5d4d5" })
hi(0, "DapUIDecoration", { fg = "#aeb3ce" })
hi(0, "DapUIModifiedValue", { link = "@variable" })
hi(0, "DapUIScope", { bold = true, fg = "#2e4477" })
hi(0, "DapUIType", { link = "Type" })
hi(0, "DapUIValue", { link = "@HlargsNamedParams" })
hi(0, "DapUIWatchesEmpty", { link = "DapUIWatchesError" })
hi(0, "DapUIWatchesError", { fg = "#c95353" })
hi(0, "DapUIWatchesValue", { fg = "#aeb3ce" })
hi(0, "Debug", { fg = "#7a4817" })
hi(0, "Delimiter", { link = "Special" })
hi(0, "DiagnosticError", { fg = "#c95353" })
hi(0, "DiagnosticHint", { fg = "#1d6a5c" })
hi(0, "DiagnosticInfo", { fg = "#196775" })
hi(0, "DiagnosticSignError", { bg = "#d7d9e1", fg = "#c95353" })
hi(0, "DiagnosticSignHint", { bg = "#d7d9e1", fg = "#1d6a5c" })
hi(0, "DiagnosticSignInfo", { bg = "#d7d9e1", fg = "#196775" })
hi(0, "DiagnosticSignWarn", { bg = "#d7d9e1", fg = "#645137" })
hi(0, "DiagnosticUnderlineError", { sp = "#c95353", undercurl = true })
hi(0, "DiagnosticUnderlineHint", { sp = "#1d6a5c", undercurl = true })
hi(0, "DiagnosticUnderlineInfo", { sp = "#196775", undercurl = true })
hi(0, "DiagnosticUnderlineWarn", { sp = "#645137", undercurl = true })
hi(0, "DiagnosticUnnecessary", { fg = "#a7acc8" })
hi(0, "DiagnosticVirtualTextError", { bg = "#dfd4d8", fg = "#c95353" })
hi(0, "DiagnosticVirtualTextHint", { bg = "#cdd6d9", fg = "#1d6a5c" })
hi(0, "DiagnosticVirtualTextInfo", { bg = "#cdd6dc", fg = "#196775" })
hi(0, "DiagnosticVirtualTextWarn", { bg = "#d5d4d5", fg = "#645137" })
hi(0, "DiagnosticWarn", { fg = "#645137" })
hi(0, "DiffAdd", { bg = "#c5d0d5" })
hi(0, "DiffChange", { bg = "#d5d9e4" })
hi(0, "DiffDelete", { bg = "#ddcace" })
hi(0, "DiffText", { bg = "#92a6d5" })
hi(0, "DiffviewDiffAddAsDelete", { bg = "#ddcace" })
hi(0, "DiffviewDim1", { fg = "#8d95ba" })
hi(0, "DiffviewFilePanelCounter", { bold = true, fg = "#8357c1" })
hi(0, "DiffviewFilePanelFileName", { fg = "#2e4477" })
hi(0, "DiffviewFilePanelTitle", { bold = true, fg = "#7933c0" })
hi(0, "DiffviewPrimary", { fg = "#3062a7" })
hi(0, "DiffviewSecondary", { fg = "#1d6a5c" })
hi(0, "Directory", { fg = "#3062a7" })
hi(0, "EndOfBuffer", { fg = "#e1e2e7" })
hi(0, "Error", { fg = "#c95353" })
hi(0, "ErrorMsg", { fg = "#c95353" })
hi(0, "FlashBackdrop", { fg = "#9298b8" })
hi(0, "FlashLabel", { bg = "#d41772", fg = "#e1e2e7" })
hi(0, "FloatBorder", { bg = "#cdd0db", fg = "#477983" })
hi(0, "FloatTitle", { bg = "#cdd0db", fg = "#477983" })
hi(0, "FoldColumn", { fg = "#8d95ba" })
hi(0, "Folded", { bg = "#aeb3ce", fg = "#3062a7" })
hi(0, "Foo", { bg = "#d41772", fg = "#2e4477" })
hi(0, "Function", { bold = true, fg = "#3062a7" })
hi(0, "GitSignsAdd", { fg = "#3f7a83" })
hi(0, "GitSignsAddNr", { bg = "#d7d9e1", bold = true, fg = "#3f7a83" })
hi(0, "GitSignsChange", { fg = "#5f79a4" })
hi(0, "GitSignsChangeNr", { bg = "#d7d9e1", bold = true, fg = "#5f79a4" })
hi(0, "GitSignsDelete", { fg = "#c7848b" })
hi(0, "GitSignsDeleteNr", { bg = "#d7d9e1", bold = true, fg = "#c7848b" })
hi(0, "GitSignsStagedAdd", { fg = "#1f3d41" })
hi(0, "GitSignsStagedAddCul", { fg = "#1f3d41" })
hi(0, "GitSignsStagedAddLn", { bg = "#c5d0d5" })
hi(0, "GitSignsStagedAddNr", { bg = "#d7d9e1", fg = "#1f3d41" })
hi(0, "GitSignsStagedChange", { fg = "#2f3c52" })
hi(0, "GitSignsStagedChangeCul", { fg = "#2f3c52" })
hi(0, "GitSignsStagedChangeLn", { bg = "#d5d9e4" })
hi(0, "GitSignsStagedChangeNr", { bg = "#d7d9e1", fg = "#2f3c52" })
hi(0, "GitSignsStagedChangedelete", { fg = "#2f3c52" })
hi(0, "GitSignsStagedChangedeleteCul", { fg = "#2f3c52" })
hi(0, "GitSignsStagedChangedeleteLn", { bg = "#d5d9e4" })
hi(0, "GitSignsStagedChangedeleteNr", { bg = "#d7d9e1", fg = "#2f3c52" })
hi(0, "GitSignsStagedDelete", { fg = "#634245" })
hi(0, "GitSignsStagedDeleteCul", { fg = "#634245" })
hi(0, "GitSignsStagedDeleteNr", { bg = "#d7d9e1", fg = "#634245" })
hi(0, "GitSignsStagedTopdelete", { fg = "#634245" })
hi(0, "GitSignsStagedTopdeleteCul", { fg = "#634245" })
hi(0, "GitSignsStagedTopdeleteNr", { bg = "#d7d9e1", fg = "#634245" })
hi(0, "HarpoonBorder", { link = "NormalFloat" })
hi(0, "HarpoonTitle", { link = "TelescopePromptTitle" })
hi(0, "HarpoonWindow", { link = "NormalFloat" })
hi(0, "HeirlineCwd", { bg = "#d3d5e1", bold = true, fg = "#3062a7" })
hi(0, "HeirlineEnd", { bg = "#d7d9e1", fg = "#d3d5e1" })
hi(0, "HeirlineErrorCount", { bg = "#c95353", fg = "#d7d9e1" })
hi(0, "HeirlineErrorWarn", { bg = "#c95353", fg = "#645137" })
hi(0, "HeirlineFileName", { bg = "#d3d5e1", bold = true, italic = true })
hi(0, "HeirlineFileStatus", { bg = "#d3d5e1" })
hi(0, "HeirlineFileType", { bg = "#d3d5e1" })
hi(0, "HeirlineGitBranch", { bg = "#8357c1", fg = "#d7d9e1" })
hi(0, "HeirlineGitLeft", { bg = "#8357c1", fg = "#d3d5e1" })
hi(0, "HeirlineGitRight", { bg = "#d3d5e1", fg = "#8357c1" })
hi(0, "HeirlineHintCount", { bg = "#1d6a5c", fg = "#d7d9e1" })
hi(0, "HeirlineHintFiletype", { bg = "#1d6a5c", fg = "#d3d5e1" })
hi(0, "HeirlineInfoCount", { bg = "#196775", fg = "#d7d9e1" })
hi(0, "HeirlineInfoHint", { bg = "#196775", fg = "#1d6a5c" })
hi(0, "HeirlineLspClients", { bg = "#d3d5e1", bold = true, italic = true })
hi(0, "HeirlineNoneError", { bg = "#d7d9e1", fg = "#c95353" })
hi(0, "HeirlineSeparator", { bg = "#d3d5e1", fg = "#828bb2" })
hi(0, "HeirlineToolsError", { bg = "#d3d5e1", fg = "#c95353" })
hi(0, "HeirlineWarnCount", { bg = "#645137", fg = "#d7d9e1" })
hi(0, "HeirlineWarnInfo", { bg = "#645137", fg = "#196775" })
hi(0, "Hlargs", { link = "@variable.parameter" })
hi(0, "IblIndent", { fg = "#c4c8da" })
hi(0, "Identifier", { link = "@keyword" })
hi(0, "IlluminatedWordRead", { sp = "#8d95ba", underline = true })
hi(0, "IlluminatedWordText", { sp = "#8d95ba", underline = true })
hi(0, "IlluminatedWordWrite", { sp = "#8d95ba", underline = true })
hi(0, "IncSearch", { bg = "#7a4817", fg = "#b9babe" })
hi(0, "Italic", { fg = "#2e4477", italic = true })
hi(0, "Keyword", { fg = "#164f65" })
hi(0, "LazyBold", { bold = true })
hi(0, "LazyItalic", { italic = true })
hi(0, "LazyProgressDone", { bold = true, fg = "#d41772" })
hi(0, "LazyProgressTodo", { bold = true, fg = "#aeb3ce" })
hi(0, "LineNr", { bg = "#d7d9e1", fg = "#aeb3ce" })
hi(0, "LineNrAbove", { bg = "#d7d9e1", fg = "#aeb3ce" })
hi(0, "LineNrBelow", { bg = "#d7d9e1", fg = "#aeb3ce" })
hi(0, "LspCodeLens", { fg = "#8d95ba" })
hi(0, "LspInfoBorder", { bg = "#cdd0db", fg = "#477983" })
hi(0, "LspInlayHint", { bg = "#dadde5", fg = "#9298b8" })
hi(0, "LspKindArray", { link = "@punctuation.bracket" })
hi(0, "LspKindBoolean", { link = "@boolean" })
hi(0, "LspKindClass", { link = "@type" })
hi(0, "LspKindColor", { link = "Special" })
hi(0, "LspKindConstant", { link = "@constant" })
hi(0, "LspKindConstructor", { link = "@constructor" })
hi(0, "LspKindEnum", { link = "@lsp.type.enum" })
hi(0, "LspKindEnumMember", { link = "@lsp.type.enumMember" })
hi(0, "LspKindEvent", { link = "Special" })
hi(0, "LspKindField", { link = "@variable.member" })
hi(0, "LspKindFile", { link = "Normal" })
hi(0, "LspKindFolder", { link = "Directory" })
hi(0, "LspKindFunction", { link = "@function" })
hi(0, "LspKindInterface", { link = "@lsp.type.interface" })
hi(0, "LspKindKey", { link = "@variable.member" })
hi(0, "LspKindKeyword", { link = "@lsp.type.keyword" })
hi(0, "LspKindMethod", { link = "@function.method" })
hi(0, "LspKindModule", { link = "@module" })
hi(0, "LspKindNamespace", { link = "@module" })
hi(0, "LspKindNull", { link = "@constant.builtin" })
hi(0, "LspKindNumber", { link = "@number" })
hi(0, "LspKindObject", { link = "@constant" })
hi(0, "LspKindOperator", { link = "@operator" })
hi(0, "LspKindPackage", { link = "@module" })
hi(0, "LspKindProperty", { link = "@property" })
hi(0, "LspKindReference", { link = "@markup.link" })
hi(0, "LspKindSnippet", { link = "Conceal" })
hi(0, "LspKindString", { link = "@string" })
hi(0, "LspKindStruct", { link = "@lsp.type.struct" })
hi(0, "LspKindText", { link = "@markup" })
hi(0, "LspKindTypeParameter", { link = "@lsp.type.typeParameter" })
hi(0, "LspKindUnit", { link = "@lsp.type.struct" })
hi(0, "LspKindValue", { link = "@string" })
hi(0, "LspKindVariable", { link = "@variable" })
hi(0, "LspReferenceRead", { bg = "#aeb3ce" })
hi(0, "LspReferenceText", { bg = "#aeb3ce" })
hi(0, "LspReferenceWrite", { bg = "#aeb3ce" })
hi(0, "LspSignatureActiveParameter", { bg = "#d0d5e5", bold = true })
hi(0, "MatchParen", { bold = true, fg = "#7a4817" })
hi(0, "ModeMsg", { bold = true, fg = "#4d577c" })
hi(0, "MoreMsg", { fg = "#3062a7" })
hi(0, "MsgArea", { fg = "#4d577c" })
hi(0, "NonText", { fg = "#9298b8" })
hi(0, "Normal", { bg = "#e1e2e7", fg = "#2e4477" })
hi(0, "NormalFloat", { bg = "#cdd0db", fg = "#2e4477" })
hi(0, "NormalNC", { fg = "#2e4477" })
hi(0, "NormalSB", { bg = "#cdd0db", fg = "#4d577c" })
hi(0, "Operator", { fg = "#164754" })
hi(0, "Pmenu", { bg = "#cdd0db", fg = "#2e4477" })
hi(0, "PmenuMatch", { bg = "#cdd0db", fg = "#205f6a" })
hi(0, "PmenuMatchSel", { bg = "#b8bcd3", fg = "#205f6a" })
hi(0, "PmenuSbar", { bg = "#c4c8d5" })
hi(0, "PmenuSel", { bg = "#b8bcd3" })
hi(0, "PmenuThumb", { bg = "#aeb3ce" })
hi(0, "PreProc", { fg = "#304e4a" })
hi(0, "Question", { fg = "#3062a7" })
hi(0, "QuickFixLine", { bg = "#b7c1e3", bold = true })
hi(0, "Repeat", { link = "Conditional" })
hi(0, "Search", { bg = "#7890dd", fg = "#2e4477" })
hi(0, "SignColumn", { bg = "#d7d9e1" })
hi(0, "SignColumnSB", { bg = "#cdd0db", fg = "#aeb3ce" })
hi(0, "Special", { fg = "#205f6a" })
hi(0, "SpecialKey", { fg = "#9298b8" })
hi(0, "SpellBad", { sp = "#c95353", undercurl = true })
hi(0, "SpellCap", { sp = "#645137", undercurl = true })
hi(0, "SpellLocal", { sp = "#196775", undercurl = true })
hi(0, "SpellRare", { sp = "#1d6a5c", undercurl = true })
hi(0, "Statement", { fg = "#7933c0" })
hi(0, "StatusLine", { bg = "#d7d9e1" })
hi(0, "StatusLineNC", { bg = "#cdd0db", fg = "#aeb3ce" })
hi(0, "Stl196775_645137__", { bg = "#645137", fg = "#196775" })
hi(0, "Stl1d6a5c_196775__", { bg = "#196775", fg = "#1d6a5c" })
hi(0, "Stl3062a7_d3d5e1_bold_", { bg = "#d3d5e1", bold = true, fg = "#3062a7" })
hi(0, "Stl645137_c95353__", { bg = "#c95353", fg = "#645137" })
hi(0, "Stl828bb2_d3d5e1__", { bg = "#d3d5e1", fg = "#828bb2" })
hi(0, "Stl_d3d5e1__", { bg = "#d3d5e1" })
hi(0, "Stl_d3d5e1_bolditalic_", { bg = "#d3d5e1", bold = true, italic = true })
hi(0, "Stl_d7d9e1__", { bg = "#d7d9e1" })
hi(0, "Stlc95353_d7d9e1__", { bg = "#d7d9e1", fg = "#c95353" })
hi(0, "Stld3d5e1_1d6a5c__", { bg = "#1d6a5c", fg = "#d3d5e1" })
hi(0, "Stld3d5e1_d7d9e1__", { bg = "#d7d9e1", fg = "#d3d5e1" })
hi(0, "Stld7d9e1_196775__", { bg = "#196775", fg = "#d7d9e1" })
hi(0, "Stld7d9e1_1d6a5c__", { bg = "#1d6a5c", fg = "#d7d9e1" })
hi(0, "Stld7d9e1_645137__", { bg = "#645137", fg = "#d7d9e1" })
hi(0, "Stld7d9e1_c95353__", { bg = "#c95353", fg = "#d7d9e1" })
hi(0, "String", { fg = "#1d6a5c" })
hi(0, "Substitute", { bg = "#b12e54", fg = "#b9babe" })
hi(0, "TabLine", { bg = "#cdd0db", fg = "#aeb3ce" })
hi(0, "TabLineFill", { bg = "#b9babe" })
hi(0, "TabLineSel", { bg = "#3062a7", fg = "#b9babe" })
hi(0, "TelescopeBorder", { bg = "#cdd0db", fg = "#477983" })
hi(0, "TelescopeMatching", { bold = true, fg = "#3062a7" })
hi(0, "TelescopeNormal", { bg = "#cdd0db", fg = "#2e4477" })
hi(0, "TelescopePreviewTitle", { bg = "#1d6a5c", fg = "#cdd0db" })
hi(0, "TelescopePromptBorder", { bg = "#c4c8da" })
hi(0, "TelescopePromptNormal", { bg = "#c4c8da" })
hi(0, "TelescopePromptTitle", { bg = "#d41772", fg = "#cdd0db" })
hi(0, "TelescopeResultsComment", { fg = "#9298b8" })
hi(0, "TelescopeResultsTitle", { fg = "#cdd0db" })
hi(0, "Title", { bold = true, fg = "#3062a7" })
hi(0, "Todo", { bg = "#645137", fg = "#e1e2e7" })
hi(0, "TreesitterContext", { bg = "#d3d5e1" })
hi(0, "Type", { fg = "#38737d" })
hi(0, "VertSplit", { fg = "#b9babe" })
hi(0, "Visual", { bg = "#b7c1e3" })
hi(0, "VisualNOS", { bg = "#b7c1e3" })
hi(0, "WarningMsg", { fg = "#645137" })
hi(0, "WhichKey", { fg = "#164f65" })
hi(0, "WhichKeyDesc", { fg = "#7933c0" })
hi(0, "WhichKeyGroup", { fg = "#3062a7" })
hi(0, "WhichKeyNormal", { bg = "#cdd0db" })
hi(0, "WhichKeySeparator", { fg = "#8d95ba" })
hi(0, "WhichKeyValue", { fg = "#747ba2" })
hi(0, "Whitespace", { fg = "#aeb3ce" })
hi(0, "WildMenu", { bg = "#b7c1e3" })
hi(0, "WinBar", { link = "StatusLine" })
hi(0, "WinBarNC", { link = "StatusLineNC" })
hi(0, "WinSeparator", { fg = "#cdd0db" })
hi(0, "debugBreakpoint", { bg = "#cdd6dc", fg = "#196775" })
hi(0, "debugPC", { bg = "#cdd0db" })
hi(0, "diffAdded", { fg = "#3f7a83" })
hi(0, "diffChanged", { fg = "#5f79a4" })
hi(0, "diffFile", { fg = "#3062a7" })
hi(0, "diffIndexLine", { fg = "#7933c0" })
hi(0, "diffLine", { fg = "#8d95ba" })
hi(0, "diffNewFile", { fg = "#7a4817" })
hi(0, "diffOldFile", { fg = "#645137" })
hi(0, "diffRemoved", { fg = "#c7848b" })
hi(0, "dosIniLabel", { link = "@property" })
hi(0, "healthError", { fg = "#c95353" })
hi(0, "healthSuccess", { fg = "#304e4a" })
hi(0, "healthWarning", { fg = "#645137" })
hi(0, "helpCommand", { bg = "#a7acc8", fg = "#3062a7" })
hi(0, "helpExample", { fg = "#8d95ba" })
hi(0, "htmlH1", { bold = true, fg = "#7933c0" })
hi(0, "htmlH2", { bold = true, fg = "#3062a7" })
hi(0, "illuminatedCurWord", { bg = "#aeb3ce" })
hi(0, "illuminatedWord", { bg = "#aeb3ce" })
hi(0, "lCursor", { bg = "#2e4477", fg = "#e1e2e7" })
hi(0, "qfFileName", { fg = "#3062a7" })
hi(0, "qfLineNr", { fg = "#747ba2" })
