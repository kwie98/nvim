local function setup(gruvbox_baby_colors, fox, C, Shade)
    -- query current color scheme
    local background = vim.fn.system("darkman get")
    if U.string_starts(background, "light") then
        vim.opt.background = "light"
    elseif U.string_starts(background, "dark") then
        vim.opt.background = "dark"
    end

    local colorscheme = "fox"

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
        local p
        if vim.opt.background:get() == "light" then
            colorscheme = "dayfox"
            p = {
                -- black = Shade.new("#1d344f", "#24476f", "#1c2f44", true),
                red = Shade.new("#b95d76", "#c76882", "#ac5169", true),
                green = Shade.new("#618774", "#629f81", "#597668", true),
                yellow = Shade.new("#ba793e", "#ca884a", "#a36f3e", true),
                blue = Shade.new("#4d688e", "#4e75aa", "#485e7d", true),
                magenta = Shade.new("#8e6f98", "#9f75ac", "#806589", true),
                cyan = Shade.new("#6ca7bd", "#74b2c9", "#5a99b0", true),
                white = Shade.new("#cdd1d5", "#cfd6dd", "#b6bcc2", true),
                orange = Shade.new("#e3786c", "#e8857a", "#d76558", true),
                pink = Shade.new("#d685af", "#de8db7", "#c9709e", true),

                bg0 = "#dbdbdb", -- Dark bg (status line and float)
                bg1 = "#eaeaea", -- Default bg
                bg2 = "#dbcece", -- Lighter bg (colorcolm folds)
                bg3 = "#ced6db", -- Lighter bg (cursor line)
                bg4 = "#bebebe", -- Conceal, border fg

                fg0 = "#182a40", -- Lighter fg
                fg1 = "#1d344f", -- Default fg
                comment = "#7f848e",

                -- sel0 = "#ced5de", -- Popup bg, visual selection bg
                -- sel1 = "#b6c4d9", -- Popup sel bg, search bg
            }

            p.git = {
                add = p.green.bright,
                removed = p.yellow.bright,
                changed = p.blue.bright,
                conflict = p.orange.bright,
                ignored = p.comment,
            }

            p.diff = {
                add = C(p.bg1):blend(C(p.git.add), 0.4):to_css(),
                delete = C(p.bg1):blend(C(p.git.removed), 0.4):to_css(),
                change = C(p.bg1):blend(C(p.git.changed), 0.4):to_css(),
                text = C(p.bg1):blend(C(p.git.conflict), 0.2):to_css(),
            }
        else
            -- print("yo")
            colorscheme = "nightfox"
            p = {
                red = Shade.new("#fb4934", 0.15, -0.15),
                -- green = Shade.new("#98971a", "#8ec07c", "#689d6a"),
                green = Shade.new("#98971a", 0.15, -0.15),
                yellow = Shade.new("#eebd35", 0.15, -0.15),
                blue = Shade.new("#458588", 0.15, -0.15),
                magenta = Shade.new("#b16286", 0.15, -0.15),
                cyan = Shade.new("#7fa2ac", 0.15, -0.15),
                white = Shade.new("#e7d7ad", 0.15, -0.15),
                orange = Shade.new("#d65d0e", 0.15, -0.15),
                pink = Shade.new("#d4879c", 0.15, -0.15),

                -- bright_yellow = Shade.new("#fabd2f", 0.15, -0.15),
                -- dark_red = Shade.new("#cc241d", 0.15, -0.15),
                -- dark_gray = Shade.new("#83a598", 0.15, -0.15),
                forest_green = Shade.new("#689d6a", 0.15, -0.15),
                clean_green = Shade.new("#8ec07c", 0.15, -0.15),

                bg0 = "#242424", -- DONE Dark bg (status line and float)
                bg1 = "#282828", -- DONE Default bg
                bg2 = "#32302f", -- DONE Lighter bg (colorcolm folds)
                bg3 = "#32302f", -- DONE Lighter bg (cursor line)
                bg4 = "#504945", -- DONE nvim-tree folder lines Conceal, telescope border fg

                fg1 = "#ebdbb2", -- DONE Default fg
                comment = "#665c54",
            }
            -- p.diag = {
            --     error = p.red.base,
            --     warn = p.yellow.base,
            --     info = p.blue.base,
            --     hint = p.green.base,
            -- }

            -- p.diag_bg = {
            --     error = C(p.bg1):blend(C(p.diag.error), 0.2):to_css(),
            --     warn = C(p.bg1):blend(C(p.diag.warn), 0.2):to_css(),
            --     info = C(p.bg1):blend(C(p.diag.info), 0.2):to_css(),
            --     hint = C(p.bg1):blend(C(p.diag.hint), 0.2):to_css(),
            -- }

            p.git = {
                add = p.clean_green.dim,
                removed = p.yellow.dim,
                changed = p.blue.dim,
                conflict = p.orange.dim,
                ignored = p.comment,
            }

            p.diff = {
                add = C(p.bg1):blend(C(p.git.add), 0.25):to_css(),
                delete = C(p.bg1):blend(C(p.git.removed), 0.25):to_css(),
                change = C(p.bg1):blend(C(p.git.changed), 0.25):to_css(),
                text = C(p.bg1):blend(C(p.git.conflict), 0.2):to_css(),
            }
        end
        fox.reset()
        fox.setup({
            -- dim_inactive = true,
            options = {
                terminal_colors = false,
                -- dim_inactive = true,
                styles = {
                    comments = "italic",
                    functions = "bold",
                    types = "italic",
                    keywords = "italic",
                },
            },
            palettes = {
                dayfox = {
                    -- diff = {
                    --     add = "#aec5b9",
                    --     change = "#a1b3cc",
                    --     delete = "#dcaeba",
                    -- },
                    -- number0 = "#182a40", -- fg0
                    -- number1 = "#1d344f", -- fg1
                },
                nightfox = {
                    red = p.red,
                    green = p.green,
                    yellow = p.yellow,
                    blue = p.blue,
                    magenta = p.magenta,
                    cyan = p.cyan,
                    white = p.white,
                    orange = p.orange,
                    pink = p.pink,

                    comment = p.comment,
                    bg0 = p.bg0, -- dark bg
                    bg1 = p.bg1, -- default bg
                    bg2 = p.bg2, -- colorcolumn folds
                    bg3 = p.bg3, -- cursor line
                    bg4 = p.bg4,
                    fg1 = p.fg1, -- DONE Default fg
                    sel0 = p.bg4, -- Popup bg, visual selection bg

                    number0 = p.comment, -- current number
                    number1 = p.bg4, -- number
                },
            },
            specs = {
                nightfox = {
                    syntax = {
                        func = p.yellow,
                        keyword = p.red,
                        type = p.clean_green,
                        ident = p.blue,
                        conditional = p.red,
                    },
                    diff = p.diff,
                    git = p.git,
                },
                dayfox = {
                    diff = p.diff,
                    git = p.git,
                },
            },
            groups = {
                dayfox = {
                    LineNr = { fg = p.fg0 },
                    CursorLineNr = { fg = p.fg1 },
                    -- gitsigns stuff:
                    -- GitSignsAddNr = { fg = p.bg0, bg = p.diff.add },
                    -- GitSignsChangeNr = { fg = p.bg0, bg = p.diff.change },
                    -- GitSignsDeleteNr = { fg = p.bg0, bg = p.diff.delete },
                    -- DiffAdd = { bg = p.diff.add },
                    -- DiffChange = { bg = p.diff.change },
                    -- DiffDelete = { bg = p.diff.delete },
                    -- telescope:
                    -- TelescopeBorder = { fg = p.fg1, bg = p.fg1 },
                    -- TelescopePromptCounter = { fg = p.fg1, bg = p.bg4 },
                    -- TelescopePromptBorder = { fg = p.bg4, bg = p.bg4 },
                    -- TelescopePromptNormal = { fg = p.fg1, bg = p.bg4 },
                    -- TelescopePromptPrefix = { fg = p.cyan, bg = p.bg4 },

                    -- TelescopeNormal = { bg = p.bg0 },

                    -- TelescopePreviewTitle = { fg = p.bg1, bg = p.green.dim },
                    -- TelescopePromptTitle = { fg = p.bg1, bg = p.yellow },
                    -- TelescopeResultsTitle = { fg = p.bg0, bg = p.fg1 },
                },
                nightfox = {
                    LineNr = { fg = p.bg4 },
                    CursorLineNr = { fg = p.comment },
                    -- better syntax:
                    ["@punctuation.delimiter"] = { fg = p.fg1 }, -- brackets
                    ["@punctuation.bracket"] = { fg = p.fg1 }, -- brackets
                    ["@constructor"] = { fg = p.clean_green }, -- lua table brackets
                    ["@field"] = { fg = p.cyan }, -- lua table fields
                    ["@constant.builtin"] = { fg = p.pink }, -- python None
                    ["@keyword.operator"] = { fg = p.red, style = "NONE" }, -- lua "not" with no italics/bold
                    ["@variable"] = { fg = p.blue }, -- "normal" variables different from fields :)
                    ["@parameter"] = { fg = p.blue.dim }, -- python foo(x=...)
                    -- window borders:
                    VertSplit = { fg = p.bg4 },
                    FloatBorder = { fg = p.bg4 },
                    NormalFloat = { bg = p.bg1 },
                    ColorColumn = { bg = p.bg0 },
                    TreesitterContext = { bg = p.bg0 },
                },
                all = {
                    TelescopeBorder = { fg = p.bg0, bg = p.bg0 },
                    TelescopePromptCounter = { fg = p.fg1, bg = p.bg4 },
                    TelescopePromptBorder = { fg = p.bg4, bg = p.bg4 },
                    TelescopePromptNormal = { fg = p.fg1, bg = p.bg4 },
                    TelescopePromptPrefix = { fg = p.cyan, bg = p.bg4 },
                    TelescopeNormal = { bg = p.bg0 },
                    TelescopePreviewTitle = { fg = p.bg1, bg = p.green.dim },
                    TelescopePromptTitle = { fg = p.bg1, bg = p.yellow },
                    TelescopeResultsTitle = { fg = p.bg0, bg = p.fg1 },

                    ["@text.title"] = { style = "bold" },
                    ["@text.note"] = { fg = p.cyan.dim, style = "bold" },
                    ["@text.warning"] = { fg = p.yellow.dim, style = "bold" },
                    ["@function.builtin"] = { fg = p.magenta },
                    ["@variable.builtin"] = { fg = p.magenta },
                    ["@punctuation.special"] = { fg = p.comment },
                },
            },
        })
        fox.compile()
    end

    -- vim.opt.background = background
    -- vim.cmd.colorscheme(colorscheme)
    local ok, _ = pcall(vim.cmd.colorscheme, colorscheme)
    if not ok then
        return
    end
    if colorscheme == "dayfox" then
        vim.cmd("highlight codeBlockBackground guibg=#dbdbdb")
    else
        vim.cmd("highlight codeBlockBackground guibg=#242424")
    end

    -- vim.cmd([[
    --     try
    --         " colorscheme gruvbox-material
    --         colorscheme gruvbox-baby
    --     catch /^Vim\%((\a\+)\)\=:E185/
    --         colorscheme default
    --     endtry
    -- ]])
end

U.load({ "gruvbox-baby.colors", "nightfox", "nightfox.lib.color", "nightfox.lib.shade" }, setup)
