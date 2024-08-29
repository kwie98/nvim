---@diagnostic disable: undefined-field
return {
    "folke/tokyonight.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    lazy = true, -- loaded by hlargs

    config = function()
        local util = require("tokyonight.util")

        local function is_bright(key) -- match colors that I find too bright
            if type(key) ~= "string" then return false end
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
                        colors[color] = util.darken(hex, 0.9)
                    end
                end
            end
            return colors
        end

        require("tokyonight").setup({
            transparent = true,
            terminal_colors = false,
            styles = {
                comments = { italic = false },
                keywords = { italic = false },
            },
            sidebars = { "no please :)" }, -- disable darkening of any sidebars
            day_brightness = 0.05, -- lower = higher contrast
            -- day_brightness = 0.0,
            on_colors = function(c)
                c = darken_all(c)

                c.bg_highlight_strong = c.bg_highlight
                c.bg_highlight = util.blend(c.bg, 0.5, c.bg_highlight_strong)
                c.light_comment = util.lighten(c.comment, 0.9)
                c.lighter_comment = util.lighten(c.comment, 0.8)
                c.bg_medium = util.blend(c.bg, 0.5, c.bg_statusline)
            end,

            -- c = {
            --     bg = "#1a1b26",
            --     bg_dark = "#16161e",
            --     bg_float = "#16161e",
            --     bg_highlight = "#222534",
            --     bg_highlight_strong = "#292e42",
            --     bg_medium = "#181922",
            --     bg_popup = "#16161e",
            --     bg_search = "#3d59a1",
            --     bg_sidebar = "#16161e",
            --     bg_statusline = "#16161e",
            --     bg_visual = "#283457",
            --     black = "#16171f",
            --     blue = "#7095e2",
            --     blue0 = "#3a5395",
            --     blue1 = "#28b2cc",
            --     blue2 = "#0ea9c5",
            --     blue5 = "#7ecae9",
            --     blue6 = "#a5e3e3",
            --     blue7 = "#364669",
            --     border = "#16171f",
            --     border_highlight = "#2694aa",
            --     comment = "#50587f",
            --     cyan = "#73bde9",
            --     dark3 = "#4e5675",
            --     dark5 = "#6a7196",
            --     delta = {
            --         add = "#2a5460",
            --         delete = "#682f35",
            --     },
            --     diff = {
            --         add = "#20303b",
            --         change = "#1f2231",
            --         delete = "#37222c",
            --         text = "#394b70",
            --     },
            --     error = "#c84647", -- red1
            --     fg = "#afb9e0",
            --     fg_dark = "#9ba2c4",
            --     fg_float = "#afb9e0",
            --     fg_gutter = "#383e5b",
            --     fg_sidebar = "#9ba2c4",
            --     git = {
            --         add = "#40909e",
            --         change = "#5a79ac",
            --         delete = "#85474f",
            --         ignore = "#4e5675",
            --     },
            --     gitSigns = {
            --         add = "#266d6a",
            --         change = "#536c9e",
            --         delete = "#b2555b",
            --     },
            --     green = "#91bc63", -- unused (?) because ugly
            --     green1 = "#6ac7ba",
            --     green2 = "#3d98a7",
            --     hint = "#1aac90", -- teal
            --     info = "#0ea9c5", -- blue2
            --     light_comment = "#62698c",
            --     lighter_comment = "#737999",
            --     magenta = "#ab8de2",
            --     magenta2 = "#e80373",
            --     none = "NONE",
            --     orange = "#e8915e",
            --     purple = "#9073c6",
            --     red = "#e16d84",
            --     red1 = "#c84647",
            --     teal = "#1aac90", -- strings
            --     terminal_black = "#3d4461",
            --     warning = "#cca061", -- yellow
            --     yellow = "#cca061",
            -- }

            on_highlights = function(hl, c)
                hl.HeirlineSeparator = { fg = c.light_comment, bg = c.bg_highlight }
                hl.HeirlineEnd = { fg = c.bg_highlight, bg = c.bg_medium }
                hl.HeirlineCwd = { fg = c.blue, bg = c.bg_highlight, bold = true }
                hl.HeirlineFileName = { bg = c.bg_highlight, bold = true, italic = true }
                hl.HeirlineFileStatus = { bg = c.bg_highlight }
                hl.HeirlineGitLeft = { fg = c.bg_highlight, bg = c.purple }
                hl.HeirlineGitBranch = { fg = c.bg_medium, bg = c.purple }
                hl.HeirlineGitRight = { fg = c.purple, bg = c.bg_highlight }
                hl.HeirlineLspClients = { bg = c.bg_highlight, bold = true, italic = true }
                hl.HeirlineNoneError = { fg = c.error, bg = c.bg_medium }
                hl.HeirlineToolsError = { fg = c.error, bg = c.bg_highlight }
                hl.HeirlineErrorCount = { fg = c.bg_medium, bg = c.error }
                hl.HeirlineErrorWarn = { fg = c.warning, bg = c.error }
                hl.HeirlineWarnCount = { fg = c.bg_medium, bg = c.warning }
                hl.HeirlineWarnInfo = { fg = c.info, bg = c.warning }
                hl.HeirlineInfoCount = { fg = c.bg_medium, bg = c.info }
                hl.HeirlineInfoHint = { fg = c.hint, bg = c.info }
                hl.HeirlineHintCount = { fg = c.bg_medium, bg = c.hint }
                hl.HeirlineHintFiletype = { fg = c.bg_highlight, bg = c.hint }
                hl.HeirlineFileType = { bg = c.bg_highlight }
                hl.StatusLine = { bg = c.bg_medium }

                hl.IblIndent = { fg = c.bg_highlight_strong }
                -- hl.black = {fg = c.terminal_black}
                -- hl.red = {fg = c.red}
                -- hl.green = {fg = c.green1}
                -- hl.yellow = {fg = c.yellow}
                -- hl.blue = {fg = c.blue}
                -- hl.magenta = {fg = c.magenta2}
                -- hl.cyan = {fg = c.cyan}

                hl.FlashLabel = { fg = c.bg, bg = c.magenta2 }

                -- hl.WinSeparator = { fg = c.bg_dark, bg = c.bg }
                hl.WinSeparator = { fg = c.bg_dark }

                hl.TelescopePromptNormal = { bg = c.bg_highlight_strong }
                hl.TelescopePromptBorder = { bg = c.bg_highlight_strong }
                hl.TelescopePromptTitle = { fg = c.bg_float, bg = c.magenta2 }
                hl.TelescopeResultsTitle = { fg = c.bg_float }
                hl.TelescopePreviewTitle = { fg = c.bg_float, bg = c.teal }

                hl.HarpoonWindow = { link = "NormalFloat" }
                hl.HarpoonBorder = { link = "NormalFloat" }
                hl.HarpoonTitle = { link = "TelescopePromptTitle" }

                -- Fuzzy matches:
                hl.TelescopeMatching = { fg = c.blue, bold = true }
                hl.CmpItemAbbrMatch = { fg = c.blue, bold = true }
                hl.CmpItemAbbrMatchFuzzy = { link = "CmpItemAbbrMatch" }

                -- Highlight word/references under cursor:
                hl.IlluminatedWordText = { underline = true, sp = c.comment } -- would highlight lua function, end
                hl.IlluminatedWordRead = { underline = true, sp = c.comment }
                hl.IlluminatedWordWrite = { underline = true, sp = c.comment }

                -- Signs:
                hl.SignColumn = { bg = c.bg_medium }
                hl.DiagnosticSignError = { fg = c.error, bg = c.bg_medium }
                hl.DiagnosticSignWarn = { fg = c.warning, bg = c.bg_medium }
                hl.DiagnosticSignHint = { fg = c.hint, bg = c.bg_medium }
                hl.DiagnosticSignInfo = { fg = c.info, bg = c.bg_medium }

                -- Numbers:
                hl.GitSignsAddNr = { bg = c.bg_medium, fg = c.git.add, bold = true}
                hl.GitSignsChangeNr = { bg = c.bg_medium, fg = c.git.change, bold = true }
                hl.GitSignsDeleteNr = { bg = c.bg_medium, fg = c.git.delete, bold = true }
                hl.LineNr = { fg = c.fg_gutter, bg = c.bg_medium }
                hl.LineNrAbove = { fg = c.fg_gutter, bg = c.bg_medium }
                hl.LineNrBelow = { fg = c.fg_gutter, bg = c.bg_medium }
                hl.CursorLineNr = { fg = c.dark5, bg = c.bg_medium }

                hl.ColorColumn = { bg = c.bg_medium }

                -- Cursor line of current window:
                hl.CursorLineCurrent = { bg = c.bg_highlight_strong }

                hl.TreesitterContext = { bg = c.bg_highlight }

                hl["@keyword"] = { fg = c.purple } -- def, struct, pub, let. WAS purple
                hl["@keyword.function"] = { link = "@keyword" } -- WAS magenta
                hl["@keyword.import"] = { link = "@keyword" } -- from ... import, use. WAS cyan
                hl["@type.qualifier"] = { link = "@keyword" } -- mut (before semantic hl kicks in)
                hl.Identifier = { link = "@keyword" }

                -- if, for, while, return:
                hl.Conditional = { fg = c.purple, italic = true } -- WAS magenta
                hl["@controlFlow"] = { link = "Conditional" } -- rust LSP
                hl["@keyword.return"] = { link = "Conditional" }
                hl.Repeat = { link = "Conditional" }
                hl["@exception"] = { link = "Conditional" } -- try, catch?

                -- hl["@module"] = { link = "@variable" } -- python cannot differentiate these, so keep it consistent. WAS cyan
                hl["@variable.parameter"] = { italic = true }
                -- hl["@parameter.python"] = {}
                hl.Hlargs = { link = "@variable.parameter" }
                -- hl["@HlargsNamedParams"] = {fg = c.comment, style = "reverse"}
                hl["@HlargsNamedParams.python"] = { fg = c.comment }
                hl["@variable.builtin"] = { fg = c.red, italic = true } -- python/rust self. WAS red

                local function_color = c.blue
                hl.Function = { fg = function_color, bold = true } -- WAS blue
                hl["@function.builtin"] = { fg = util.lighten(function_color, 0.85), bold = true } -- builtin functions. doesn't work in rust, lua because it gets overwritten by semantic tokens from the LSP. WAS blue1

                hl["@variable.member"] = { fg = c.blue2 } -- table/dict keys. WAS green1
                hl["@label"] = { link = "@variable.member" } -- json keys. WAS blue
                hl["@property"] = { link = "@variable.member" }

                hl.String = { fg = c.teal } -- WAS green
                -- hl.Comment = { fg = c.comment }
                hl["@string.regexp"] = { link = "Constant" }
                hl["@string.documentation"] = { fg = c.light_comment }
                hl["@comment.documentation"] = { fg = c.light_comment } -- doesn't work yet

                hl.PreProc = { fg = c.green1 } -- rust macros

                local type_color = c.green2
                hl.Type = { fg = type_color } -- WAS blue1
                hl["@lsp.type.interface.typescript"] = { link = "Type" } -- typescript interfaces are weird
                hl["@type.builtin"] = { fg = type_color }
                -- hl["@type.builtin"] = { fg = util.darken(type_color, 0.8) }
                -- hl["@enumMember"] = { fg = type_color, style = "italic" }

                hl["@punctuation.bracket"] = { fg = c.light_comment }
                hl["@tag.delimiter"] = { link = "@punctuation.bracket" } -- html <div> </div> brackets
                -- hl.luaParenError = { link = "@punctuation.bracket" } -- fix for LSP hover windows in lua having red parens
                hl["@punctuation.delimiter"] = { fg = c.lighter_comment } -- , ;
                hl["@operator"] = { fg = c.fg } -- + &
                hl["@punctuation.special"] = { link = "@punctuation.bracket" } -- python f-string {} brackets
                hl["@formatSpecifier"] = { link = "@punctuation.bracket" } -- rust string formatting {} brackets

                hl["@constant.builtin"] = { fg = c.orange } -- python None

                hl["@constructor"] = { link = "Type" } -- __init__, object constructors

                hl.DapUIType = { link = "Type" }
                hl.DapUIModifiedValue = { link = "@variable" }
                hl.DapUIValue = { link = "@HlargsNamedParams" }
                hl.DapUIScope = { fg = c.fg, bold = true }
                hl.DapUIDecoration = { fg = c.fg_gutter }
                hl.DapUIWatchesError = { fg = c.error }
                hl.DapUIWatchesEmpty = { link = "DapUIWatchesError" }
                hl.DapUIWatchesValue = { fg = c.fg_gutter }

                hl["@markup.raw.block.markdown"] = {} -- removes highlighting for this group
                hl["@markup.list.markdown"] = { link = "@punctuation.bracket" }
                hl["@markup.link.label"] = { link = "@markup.link.url" }
                hl["@markup.italic"] = { italic = true }
            end,
        })
        -- Set colorscheme to current system mode:
        require("kwie.darkman")
    end,
}
