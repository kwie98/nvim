U.load({ "gruvbox-baby.colors", "nightfox" }, function(gruvbox_baby_colors, fox)
    -- query current color scheme
    local background = vim.fn.system("darkman get")
    -- vim.opt.background = background
    -- print(background)
    if U.string_starts(background, "light") then
        vim.opt.background = "light"
    elseif U.string_starts(background, "dark") then
        vim.opt.background = "dark"
    end

    local colorscheme = "fox"
    -- local colorscheme = "gruvbox-baby"

    if colorscheme == "gruvbox-material" then
        vim.g.gruvbox_material_palette = "original"
        vim.g.gruvbox_material_background = "medium"
        vim.g.gruvbox_material_enable_italic = 1
        vim.g.gruvbox_material_disable_italic_comment = 0
        vim.g.gruvbox_material_enable_bold = 1
        vim.g.gruvbox_material_sign_column_background = "none"
        vim.g.gruvbox_material_ui_contrast = "high"
        vim.g.gruvbox_material_statusline_style = "original"
        vim.g.gruvbox_material_disable_terminal_colors = 1
    elseif colorscheme == "gruvbox-baby" then
        local colors = gruvbox_baby_colors.config()
        colors.custom = {
            split = "#504945",
            -- https://mdigi.tools/color/
            diff = {
                --     #26332c
                add = "#13462b",
                --        #273842
                change = "#133d55",
                --        #572e33
                delete = "#6e1722",
            },
        }
        vim.g.gruvbox_baby_background_color = "medium"
        vim.g.gruvbox_baby_use_original_palette = false
        vim.g.gruvbox_baby_highlights = {
            -- GitSignsAdd = { bg = colors.medium_gray, fg = colors.custom.diff.add, style = "bold" },
            -- GitSignsChange = { bg = colors.medium_gray, fg = colors.custom.diff.change, style = "bold" },
            -- GitSignsDelete = { bg = colors.medium_gray, fg = colors.custom.diff.delete, style = "bold" },
            GitSignsAddNr = { fg = colors.comment, bg = colors.diff.add, style = "bold" },
            GitSignsChangeNr = { fg = colors.comment, bg = colors.diff.change, style = "bold" },
            GitSignsDeleteNr = { fg = colors.comment, bg = colors.diff.delete, style = "bold" },
            DiffAdd = { bg = colors.diff.add }, -- removes syntax highlighting
            DiffChange = { bg = colors.diff.change }, -- removes syntax highlighting
            DiffDelete = { bg = colors.diff.delete }, -- removes syntax highlighting
            VertSplit = { fg = colors.custom.split },
            LineNr = { fg = colors.custom.split, style = "bold" },
        }
        vim.g.gruvbox_baby_telescope_theme = 1
    elseif colorscheme == "fox" then
        if vim.opt.background:get() == "light" then
            colorscheme = "dayfox"
        else
            colorscheme = "nightfox"
        end
        local Shade = require("nightfox.lib.shade")
        fox.reset()
        fox.setup({
            -- dim_inactive = true,
            options = {
                styles = {
                    comments = "italic",
                    functions = "bold",
                    types = "italic",
                    keywords = "italic",
                },
            },
            palettes = {
                nightfox = {
                    -- black = Shade.new("#393b44"),
                    red = Shade.new("#fb4934", "#fb4934", "#fb4934"),
                    green = Shade.new("#98971a", "#8ec07c", "#689d6a"),
                    yellow = Shade.new("#eebd35", "#eebd35", "#eebd35"),
                    blue = Shade.new("#458588", "#458588", "#458588"),
                    magenta = Shade.new("#b16286", "#b16286", "#b16286"),
                    cyan = Shade.new("#7fa2ac", "#7fa2ac", "#7fa2ac"),
                    white = Shade.new("#e7d7ad", "#e7d7ad", "#e7d7ad"),
                    orange = Shade.new("#d65d0e", "#d65d0e", "#d65d0e"),
                    pink = Shade.new("#d4879c", "#d4879c", "#d4879c"),

                    comment = "#665c54",

                    bg0 = "#242424", -- DONE Dark bg (status line and float)
                    bg1 = "#282828", -- DONE Default bg
                    bg2 = "#32302f", -- DONE Lighter bg (colorcolm folds)
                    bg3 = "#32302f", -- DONE Lighter bg (cursor line)
                    bg4 = "#8094B4", -- DONE nvim-tree folder lines Conceal, border fg

                    -- fg0 = "#d6d6d7", -- Lighter fg
                    fg1 = "#ebdbb2", -- DONE Default fg
                    -- fg2 = "#aeafb0", -- Darker fg (status line)
                    -- fg3 = "#71839b", -- Darker fg (line numbers, fold columns)

                    sel0 = "#504945", -- Popup bg, visual selection bg
                    -- sel1 = "#3c5372", -- Popup sel bg, search bg
                },
            },
            specs = {
                nightfox = {
                    syntax = {
                        func = "yellow",
                        keyword = "red",
                        type = "green.bright",
                        ident = "blue",
                        conditional = "red",
                        -- variable = "red"
                    },
                },
            },
            groups = {
                nightfox = {
                    ["@punctuation.delimiter"] = { fg = "palette.fg1" }, -- brackets
                    ["@constructor"] = { fg = "palette.green.bright" }, -- lua tables
                    ["@field"] = { fg = "palette.cyan" }, -- lua table fields
                    ["@constant.builtin"] = { fg = "palette.pink" }, -- python None
                    ["@keyword.operator"] = { fg = "palette.red" }, -- lua "not" with no italics
                    ["@variable"] = { fg = "palette.blue" },
                },
            },
        })
    end

    -- vim.opt.background = background
    -- vim.cmd.colorscheme(colorscheme)
    local ok, _ = pcall(vim.cmd.colorscheme, colorscheme)
    if not ok then
        return
    end

    -- vim.cmd([[
    --     try
    --         " colorscheme gruvbox-material
    --         colorscheme gruvbox-baby
    --     catch /^Vim\%((\a\+)\)\=:E185/
    --         colorscheme default
    --     endtry
    -- ]])
end)
