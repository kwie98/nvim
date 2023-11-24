return {
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

            local function is_bright(key) -- match colors that I find too bright
                if vim.startswith(key, "bg_") then
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
                excluded_filetypes = { "TelescopePrompt", "TelescopeResults", "harpoon" },
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
                sidebars = nil, -- don't make help pages darker
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
                    -- hl.TermNormal = {fg = "#a8a8a8", bg =  "#161616"}

                    hl.NvimTreeWinSeparator = { fg = c.fg_gutter, bg = c.bg_sidebar }
                    hl.WinSeparator = { fg = c.fg_gutter, bg = c.bg_sidebar }
                    hl.BufferLineNvimTreeRootFolder = { fg = c.blue, bg = "#0e0e14", style = "bold" } -- like NvimTreeRootFolder

                    -- Fuzzy matches:
                    hl.TelescopeMatching = { fg = c.blue, style = "bold" }
                    hl.CmpItemAbbrMatch = { fg = c.blue, style = "bold" }

                    hl.IlluminatedWordText = { sp = c.bg } -- would highlight lua function, end
                    hl.IlluminatedWordRead = { style = "underline", sp = c.comment }
                    hl.IlluminatedWordWrite = { style = "underline", sp = c.comment }

                    hl.SignColumn = { bg = c.bg_medium }
                    hl.GitSignsAddNr = { bg = c.bg_medium, fg = c.gitSigns.add }
                    hl.GitSignsChangeNr = { bg = c.bg_medium, fg = c.gitSigns.change }
                    hl.GitSignsDeleteNr = { bg = c.bg_medium, fg = c.gitSigns.delete }

                    hl.LineNr = { fg = c.fg_gutter, bg = c.bg_medium }
                    hl.CursorLineNr = { fg = c.dark5, bg = c.bg_medium }
                    hl.CursorLineCurrent = { bg = c.bg_highlight_strong }

                    hl.TreesitterContext = { bg = c.bg_highlight_strong }

                    hl["@keyword"] = { fg = c.purple, style = "NONE" } -- def, struct, pub, let. WAS purple
                    hl["@keyword.function"] = { link = "@keyword" } -- WAS magenta
                    hl["@include"] = { link = "@keyword" } -- from ... import, use. WAS cyan
                    hl["@type.qualifier"] = { link = "@keyword" } -- mut (before semantic hl kicks in)
                    hl.Identifier = { link = "@keyword" }

                    -- if, for, while, return:
                    hl.Conditional = { fg = c.purple, style = "italic" } -- WAS magenta
                    hl["@controlFlow"] = { link = "Conditional" } -- rust LSP
                    hl["@keyword.return"] = { link = "Conditional" }
                    hl.Repeat = { link = "Conditional" }
                    hl["@exception"] = { link = "Conditional" } -- try, catch?

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
                    hl["@punctuation.special"] = { link = "@operator" } -- python f-string {} brackets
                    hl["@formatSpecifier"] = { link = "@operator" } -- rust string formatting {} brackets

                    hl["@constructor"] = { link = "Type" } -- __init__, object constructors

                    hl.DapUIType = { link = "Type" }
                    hl.DapUIModifiedValue = { link = "@variable" }
                    hl.DapUIValue = { link = "@HlargsNamedParams" }
                    hl.DapUIScope = { fg = c.fg, style = "bold" }
                    hl.DapUIDecoration = { fg = c.fg_gutter }
                    hl.DapUIWatchesError = { fg = c.error }
                    hl.DapUIWatchesEmpty = { link = "DapUIWatchesError" }
                    hl.DapUIWatchesValue = { fg = c.fg_gutter }

                    -- Luasnip:
                    hl.ChoiceNode = { style = "underline", sp = c.yellow }
                    hl.InsertNode = { style = "underline", sp = c.blue }
                end,
            })
            require("kwie.darkman")
        end,
    },
}
