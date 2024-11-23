if vim.g.colors_name ~= nil then vim.cmd("highlight clear") end
vim.g.colors_name = "tokyonight-day"
local hi = function(...) vim.api.nvim_set_hl(0, ...) end

local fg = {
    medium = "#172554",
    soft = "#1e3a8a",
    softer = "#1e40af",
}
local bg = {
    medium = "#ffffff",
    soft = "#f9fafb",
    softer = "#f3f4f6",
    softest = "#e5e7eb",
    softestest = "#d1d5db",
}

local red = {
    bg = "#fee2e2",
}
local blue = {
    medium = "#0369a1",
    soft = "#0284c7",
    softer = "#0ea5e9",
    softest = "#38bdf8",
    bg_harder = "#7dd3fc",
    bg_hard = "#bae6fd",
    bg = "#e0f2fe",
}
local cyan = {
    hard = "#0e7490",
    medium = "#0891b2",
}
local green = {
    hardest = "#064e3b",
    harder = "#065f46",
    hard = "#047857",
    medium = "#059669",
    soft = "#10b981",
    softer = "#34d399",
    softest = "#6ee7b7",
    softestest = "#a7f3d0",
}
local magenta = {
    hardest = "#831843",
    harder = "#9d174d",
    hard = "#be185d",
    medium = "#db2777",
    soft = "#ec4899",
    softer = "#f472b6",
}
local yellow = {
    hard = "#a16207",
    medium = "#ca8a04",
    -- soft
    -- softer
    softest = "#fde047",
    bg_hard = "#fef08a",
    bg = "#fef9c3",
}

-- Background:
hi("Normal", { fg = fg.medium, bg = bg.medium })
hi("NormalFloat", { bg = bg.soft })
hi("TelescopeNormal", { link = "NormalFloat" })
hi("TelescopePromptNormal", { bg = bg.softer })
hi("TelescopePromptBorder", { link = "TelescopePromptNormal" })
hi("TelescopePromptTitle", { bg = yellow.softest })

hi("CursorLine", { bg = bg.soft })
hi("CursorLineCurrent", { bg = bg.softer })
hi("WinSeparator", { fg = bg.softest })

-- Columns:
hi("SignColumn", { bg = bg.soft })
hi("LineNr", { fg = bg.softestest, bg = bg.soft })
hi("CursorLineNr", { bg = bg.soft, bold = true })
hi("ColorColumn", { bg = bg.soft })

-- Searching:
hi("Substitute", { bg = yellow.softest })
hi("Search", { bg = yellow.softest })
hi("IncSearch", { link = "Search" })
hi("CurSearch", { fg = bg.medium, bg = yellow.hard })

hi("FlashLabel", { fg = bg.medium, bg = magenta.medium })
hi("MatchParen", { fg = yellow.medium, bold = true })

-- Git:
hi("DiffAdd", { bg = blue.bg })
hi("DiffChange", { bg = blue.bg })
hi("DiffText", { bg = blue.bg_harder })
hi("DiffDelete", { bg = red.bg })

-- Syntax:
hi("Statement", { fg = fg.soft })
hi("Conditional", { italic = true })
hi("@controlFlow", { link = "Conditional" }) -- rust LSP
hi("@keyword.return", { link = "Conditional" })
hi("@keyword.conditional", { link = "Conditional" })
hi("Repeat", { link = "Conditional" })
hi("@exception", { link = "Conditional" })
hi("Function", { fg = fg.soft, bold = true })
hi("@function.builtin", { fg = fg.medium, bold = true })
hi("@variable", { fg = magenta.hard })
hi("@variable.parameter", { fg = magenta.harder, italic = true })
hi("HlArgs", { link = "@variable.parameter" })
