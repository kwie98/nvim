return {
    {
        "rktjmp/lush.nvim",
        lazy = false,
        enabled = false,
    },
    {
        "Mofiqul/vscode.nvim",
        lazy = false,
        priority = 100,
        enabled = false,
    },
    {
        "folke/tokyonight.nvim",
        dependencies = {
            "m-demare/hlargs.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        lazy = false,
        priority = 100,
        config = function()
            local tokyonight = require("tokyonight")
            local hlargs = require("hlargs")
            local util = require("tokyonight.util")
            local darken = util.darken
            local lighten = util.lighten
            local blend = util.blend

            local function starts_with(str, start)
                return str:sub(1, #start) == start
            end

            local function is_bright(key) -- match colors that I find too bright
                if starts_with(key, "bg_") then
                    return false
                elseif key == "diff" or key == "none" or key == "gitSigns" then
                    return false
                end

                return true
            end

            local function darken_all(colors)
                for color, hex in pairs(colors) do
                    if is_bright(color) then
                        if type(hex) == "table" then
                            colors[color] = darken_all(colors[color])
                        else
                            colors[color] = darken(hex, 0.9)
                            -- colors[color] = darken(hex, 1.0)
                        end
                    end
                end
                return colors
            end

            hlargs.setup({
                -- highlight = { link = "@keyword" },
                extras = {
                    named_parameters = true,
                    -- excluded_argnames = {
                    --     declarations = {},
                    --     usages = {
                    --         python = { "self", "cls" },
                    --         lua = { "self" },
                    --         rust = { "self" },
                    --     },
                    -- },
                },
            })

            tokyonight.setup({
                terminal_colors = false,
                sidebars = {}, -- don't make help pages darker
                day_brightness = 0.0, -- stronger constrasts in light mode?
                on_colors = function(c)
                    c = darken_all(c)
                    -- c.bg_sidebar = darken(c.bg, 0.0, "#000000")
                    -- colors.bg_statusline = colors.bg_sidebar

                    c.bg_highlight_strong = c.bg_highlight
                    c.bg_highlight = blend(c.bg, c.bg_highlight_strong, 0.5)
                    c.light_comment = lighten(c.comment, 0.9)
                    c.lighter_comment = lighten(c.comment, 0.8)
                    c.bg_medium = blend(c.bg, c.bg_statusline, 0.5)
                end,
                on_highlights = function(hl, c)

                    hl.codeBlockBackground = { bg = c.bg_medium }
                    hl.SignColumn = { bg = c.bg_medium }
                    hl.GitSignsAddNr = { bg = c.bg_medium, fg = c.gitSigns.add }
                    hl.GitSignsChangeNr = { bg = c.bg_medium, fg = c.gitSigns.change }
                    hl.GitSignsDeleteNr = { bg = c.bg_medium, fg = c.gitSigns.delete }

                    hl.LineNr = { fg = c.fg_gutter, bg = c.bg_medium }
                    hl.CursorLineNr = { fg = c.dark5, bg = c.bg_medium }
                    hl.CursorLineCurrent = {bg=c.bg_highlight_strong}

                    hl.TreesitterContext = {bg=c.bg_highlight_strong}

                    hl["@keyword"] = { fg = c.purple, style = "NONE" } -- def, struct, pub, let. WAS purple
                    hl["@keyword.function"] = { link = "@keyword" } -- WAS magenta
                    hl["@include"] = { link = "@keyword" } -- from ... import, use. WAS cyan
                    hl["@type.qualifier"] = { link = "@keyword" } -- mut (before semantic hl kicks in)

                    -- if, for, while, return:
                    hl.Conditional = { fg = c.purple, style = "italic" } -- WAS magenta
                    hl["@controlFlow"] = { link = "Conditional" } -- rust LSP
                    hl["@keyword.return"] = { link = "Conditional" }
                    hl.Repeat = { link = "Conditional" }

                    hl["@variable"] = { fg = c.fg }
                    -- hl["@namespace"] = { link = "@variable" } -- python cannot differentiate these, so keep it consistent. WAS cyan
                    hl["@parameter"] = { style = "italic" }
                    hl.Hlargs = { link = "@parameter" }
                    -- hl["@HlargsNamedParams"] = { fg = lighten(c.comment, 0.9), style = "NONE" }
                    hl["@HlargsNamedParams"] = { fg = c.light_comment, style = "NONE" }
                    hl["@variable.builtin"] = { fg = c.red, style = "italic" } -- python/rust self. WAS red

                    hl.Function = { fg = c.blue, style = "bold" } -- WAS blue
                    hl["@function.builtin"] = { fg = lighten(c.blue, 0.85) } -- builtin functions. doesn't work in rust, lua because it gets overwritten by semantic tokens from the LSP. WAS blue1

                    hl["@field"] = { fg = c.blue2 } -- WAS green1
                    hl["@property"] = { link = "@field" }

                    hl["@string"] = { fg = c.teal } -- WAS green

                    hl.Type = { fg = c.green1 } -- WAS blue1
                    hl["@enumMember"] = { fg = c.green1, style = "italic" }

                    hl["@punctuation.bracket"] = { fg = c.light_comment }
                    hl.luaParenError = { link = "@punctuation.bracket" } -- fix for LSP hover windows in lua having red parens
                    hl["@punctuation.delimiter"] = { fg = c.lighter_comment } -- , ;
                    hl["@operator"] = { fg = c.fg } -- + &
                    hl["@punctuation.special"] = { link = "@operator" } -- f string {} brackets
                    hl["@constructor"] = { link = "Type" } -- lua table {}, __init__
                end,
            })
            require("kwie.darkman")
        end,
    },
    {
        "sainnhe/sonokai",
        lazy = false,
        priority = 100,
        enabled = false,
    },
    {
        "EdenEast/nightfox.nvim",
        lazy = false,
        priority = 100,
        enabled = false,

        config = function()
            local nightfox = require("nightfox")
            local gruv = require("plugins.color.schemes.gruv")

            nightfox.reset() -- TODO needed?
            nightfox.setup({
                options = {
                    terminal_colors = false,
                    -- inverse = {
                    --     visual = true, -- useful for checking colors
                    -- },
                },
                palettes = {
                    nightfox = gruv.palette,
                    -- dayfox = {
                    -- diff = {
                    --     add = "#aec5b9",
                    --     change = "#a1b3cc",
                    --     delete = "#dcaeba",
                    -- },
                    -- number0 = "#182a40", -- fg0
                    -- number1 = "#1d344f", -- fg1
                    -- },
                },
                specs = {
                    nightfox = {
                        diff = gruv.diff,
                        git = gruv.git,
                    },
                },
                groups = {
                    nightfox = {
                        Keyword = { fg = gruv.colors.magenta },
                        -- ["@keyword.function"] = { style = "italic" }, -- def, fn, etc
                        PreProc = { link = "Keyword" }, -- import

                        LineNr = { fg = gruv.colors.comment },
                        CursorLineNr = { fg = gruv.colors.comment },

                        ["@namespace"] = { link = "@variable" }, -- consistent with python

                        ["@controlFlow"] = { link = "Conditional" },
                        ["@keyword.return"] = { link = "Conditional" },
                        Conditional = { fg = gruv.colors.red, style = "italic" },

                        -- by default, these should link to Function -> Identifier
                        ["@function"] = { fg = gruv.colors.yellow },
                        ["@function.macro"] = { link = "Macro" },
                        Macro = { fg = gruv.colors.yellow, style = "italic" },
                        ["@function.builtin"] = { fg = gruv.colors.yellow.bright },

                        Visual = { bg = gruv.colors.softer_bg },
                        Number = { fg = gruv.colors.pink.dim },
                        ["@enumMember"] = { fg = gruv.colors.pink, style = "italic" }, -- None
                        Constant = { fg = gruv.colors.orange.dim }, -- own CONSTANTS
                        ["@constant.builtin"] = { fg = gruv.colors.orange.dim }, -- NONE
                        ["@string.escape"] = { fg = gruv.colors.pink },

                        ["@field"] = { fg = gruv.colors.blue },
                        ["@field.rust"] = { link = "@field" },

                        Operator = { fg = gruv.colors.magenta },
                        ["@keyword.operator"] = { fg = gruv.colors.magenta },

                        ["@type.builtin"] = { link = "Type" },
                        Type = { fg = gruv.colors.forest_green },

                        ["@punctuation.bracket"] = { fg = gruv.colors.softest_bg },
                        ["@punctuation.delimiter"] = { fg = gruv.colors.softest_bg },

                        ["@variable"] = { fg = gruv.colors.fg },
                        ["@variable.builtin"] = { fg = gruv.colors.fg, style = "italic" },
                        ["@parameter"] = { fg = gruv.colors.fg },
                        ["@string"] = { fg = gruv.colors.green },
                    },
                    -- dayfox = {
                    --     LineNr = { fg = p.hard_fg },
                    --     CursorLineNr = { fg = p.fg },
                    --     ["@function"] = { fg = p.red, style = "bold" },
                    --     ["@function.builtin"] = { fg = p.red.dim, style = "bold" },
                    --     ["@variable"] = { fg = p.fg }, -- "normal" variables different from fields :)
                    -- },
                    -- nightfox = {
                    --     LineNr = { fg = p.softer_bg },
                    --     CursorLineNr = { fg = p.comment },
                    --     -- better syntax:
                    --     ["@punctuation.delimiter"] = { fg = p.fg }, -- brackets
                    --     ["@punctuation.bracket"] = { fg = p.fg }, -- brackets
                    --     ["@constructor"] = { fg = p.clean_green }, -- lua table brackets
                    --     ["@field"] = { fg = p.cyan }, -- lua table fields
                    --     ["@constant.builtin"] = { fg = p.pink }, -- python None
                    --     ["@variable"] = { fg = p.blue }, -- "normal" variables different from fields :)
                    --     ["@parameter"] = { fg = p.blue.dim }, -- python foo(x=...)
                    --     ["@function"] = { fg = p.yellow, style = "bold" },
                    --     ["@function.builtin"] = { fg = p.yellow.bright, style = "bold" },
                    --     -- window borders:
                    --     VertSplit = { fg = p.softer_bg },
                    --     FloatBorder = { fg = p.softer_bg },
                    --     NormalFloat = { bg = p.bg },
                    --     ColorColumn = { bg = p.hard_bg },
                    --     TreesitterContext = { bg = p.hard_bg },
                    -- },
                    -- all = {
                    --     Conditional = { fg = p.keyword.flow },
                    --     ["@keyword.operator"] = { fg = p.keyword.flow },
                    --     Keyword = { fg = p.keyword.defs },
                    --     ["@keyword.function"] = { fg = p.keyword.defs }, -- def

                    --     ["@type"] = { fg = p.type, style = "italic" },
                    --     ["@type.builtin"] = { fg = p.type, style = "italic" },

                    --     ["@text.title"] = { style = "bold" }, -- for markdown headers
                    --     -- ["@text.note"] = { fg = p.cyan.dim, style = "bold" },
                    --     -- ["@text.warning"] = { fg = p.yellow.dim, style = "bold" },
                    --     -- ["@function.builtin"] = { fg = p.magenta },
                    --     ["@variable.builtin"] = { fg = p.blue },
                    --     ["@punctuation.special"] = { fg = p.comment }, -- for mardown list symbols and stuff

                    --     TelescopeBorder = { fg = p.hard_bg, bg = p.hard_bg },
                    --     TelescopePromptCounter = { fg = p.fg, bg = p.softer_bg },
                    --     TelescopePromptBorder = { fg = p.softer_bg, bg = p.softer_bg },
                    --     TelescopePromptNormal = { fg = p.fg, bg = p.softer_bg },
                    --     TelescopePromptPrefix = { fg = p.cyan, bg = p.softer_bg },
                    --     TelescopeNormal = { bg = p.hard_bg },
                    --     TelescopePreviewTitle = { fg = p.bg, bg = p.green.dim },
                    --     TelescopePromptTitle = { fg = p.bg, bg = p.yellow },
                    --     TelescopeResultsTitle = { fg = p.hard_bg, bg = p.fg },

                    --     -- latex:
                    --     Conceal = { fg = p.magenta },

                    --     IndentBlanklineIndent0 = { bg = p.hard_bg, style = "nocombine" },
                    --     IndentBlanklineIndent1 = { bg = p.bg, style = "nocombine" },
                    -- },
                },
            })
            nightfox.compile()

            -- if colorscheme == "dayfox" then
            --     vim.cmd("highlight codeBlockBackground guibg=#dbdbdb")
            -- else
            --     vim.cmd("highlight codeBlockBackground guibg=#242424")
            -- end

            require("kwie.darkman")
        end,
    },
}
