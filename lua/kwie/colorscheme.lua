local fox = require("nightfox")
local C = require("nightfox.lib.color")
local Shade = require("nightfox.lib.shade")

local function trim(s)
    return (s:gsub("^%s*(.-)%s*$", "%1"))
end

-- query current color scheme
local background = trim(vim.fn.system("darkman get"))
-- if string_starts(background, "light") then
--     background = "light"
-- elseif string_starts(background, "dark") then
--     background = "dark"
-- end
-- local colorscheme = ""
vim.opt.background = background
local colorscheme
local p

if background == "light" then
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
        hard_bg = "#f0f0f0", -- Dark bg (status line and float)
        bg = "#eaeaea", -- Default bg
        soft_bg = "#dbcece", -- Lighter bg (colorcolm folds)
        cursor_bg = "#ced6db", -- Lighter bg (cursor line)
        softer_bg = "#bebebe", -- Conceal, border fg
        hard_fg = "#182a40", -- Lighter fg
        fg = "#1d344f", -- Default fg
        comment = "#7f848e",
    }

    p.git = {
        add = p.green.bright,
        removed = p.yellow.bright,
        changed = p.blue.bright,
        conflict = p.orange.bright,
        ignored = p.comment,
    }

    p.diff = {
        add = C(p.bg):blend(C(p.git.add), 0.4):to_css(),
        delete = C(p.bg):blend(C(p.git.removed), 0.4):to_css(),
        change = C(p.bg):blend(C(p.git.changed), 0.4):to_css(),
        text = C(p.bg):blend(C(p.git.conflict), 0.2):to_css(),
    }

    p.keyword = {
        flow = p.magenta,
        defs = p.magenta.dim,
    }
    p.type = p.yellow
else
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
        hard_bg = "#242424", -- DONE Dark bg (status line and float)
        bg = "#282828", -- DONE Default bg
        soft_bg = "#32302f", -- DONE Lighter bg (colorcolm folds)
        cursor_bg = "#32302f", -- DONE Lighter bg (cursor line)
        softer_bg = "#504945", -- DONE nvim-tree folder lines Conceal, telescope border fg
        fg = "#ebdbb2", -- DONE Default fg
        comment = "#665c54",
    }

    p.git = {
        add = p.clean_green.dim,
        removed = p.yellow.dim,
        changed = p.blue.dim,
        conflict = p.orange.dim,
        ignored = p.comment,
    }

    p.diff = {
        add = C(p.bg):blend(C(p.git.add), 0.25):to_css(),
        delete = C(p.bg):blend(C(p.git.removed), 0.25):to_css(),
        change = C(p.bg):blend(C(p.git.changed), 0.25):to_css(),
        text = C(p.bg):blend(C(p.git.conflict), 0.2):to_css(),
    }

    p.keyword = {
        flow = p.red,
        defs = p.red.bright,
    }
    p.type = p.clean_green
end

fox.reset()

fox.setup({
    palettes = {
        -- dayfox = {
        --     -- diff = {
        --     --     add = "#aec5b9",
        --     --     change = "#a1b3cc",
        --     --     delete = "#dcaeba",
        --     -- },
        --     -- number0 = "#182a40", -- fg0
        --     -- number1 = "#1d344f", -- fg1
        -- },
        all = {
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
            bg0 = p.hard_bg, -- dark bg
            bg1 = p.bg, -- default bg
            bg2 = p.soft_bg, -- colorcolumn folds
            bg3 = p.cursor_bg, -- cursor line
            bg4 = p.softer_bg,
            fg1 = p.fg, -- DONE Default fg
            sel0 = p.softer_bg, -- Popup bg, visual selection bg

            number0 = p.comment, -- current number
            number1 = p.softer_bg, -- number
        },
    },
    options = {
        terminal_colors = false,
        -- dim_inactive = true,
        styles = {
            comments = "italic",
            -- functions = "bold",
            -- types = "italic",
            -- keywords = "italic",
        },
    },
    specs = {
        nightfox = {
            syntax = {
                -- func = p.yellow,
                -- keyword = p.red,
                -- type = p.clean_green,
                ident = p.blue,
                -- conditional = p.red,
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
            LineNr = { fg = p.hard_fg },
            CursorLineNr = { fg = p.fg },
            ["@function"] = { fg = p.red, style = "bold" },
            ["@function.builtin"] = { fg = p.red.dim, style = "bold" },
            ["@variable"] = { fg = p.fg }, -- "normal" variables different from fields :)
        },
        nightfox = {
            LineNr = { fg = p.softer_bg },
            CursorLineNr = { fg = p.comment },
            -- better syntax:
            ["@punctuation.delimiter"] = { fg = p.fg }, -- brackets
            ["@punctuation.bracket"] = { fg = p.fg }, -- brackets
            ["@constructor"] = { fg = p.clean_green }, -- lua table brackets
            ["@field"] = { fg = p.cyan }, -- lua table fields
            ["@constant.builtin"] = { fg = p.pink }, -- python None
            ["@variable"] = { fg = p.blue }, -- "normal" variables different from fields :)
            ["@parameter"] = { fg = p.blue.dim }, -- python foo(x=...)
            ["@function"] = { fg = p.yellow, style = "bold" },
            ["@function.builtin"] = { fg = p.yellow.bright, style = "bold" },
            -- window borders:
            VertSplit = { fg = p.softer_bg },
            FloatBorder = { fg = p.softer_bg },
            NormalFloat = { bg = p.bg },
            ColorColumn = { bg = p.hard_bg },
            TreesitterContext = { bg = p.hard_bg },
        },
        all = {
            Conditional = { fg = p.keyword.flow },
            ["@keyword.operator"] = { fg = p.keyword.flow },
            Keyword = { fg = p.keyword.defs },
            ["@keyword.function"] = { fg = p.keyword.defs }, -- def

            ["@type"] = { fg = p.type, style = "italic" },
            ["@type.builtin"] = { fg = p.type, style = "italic" },

            ["@text.title"] = { style = "bold" }, -- for markdown headers
            -- ["@text.note"] = { fg = p.cyan.dim, style = "bold" },
            -- ["@text.warning"] = { fg = p.yellow.dim, style = "bold" },
            -- ["@function.builtin"] = { fg = p.magenta },
            ["@variable.builtin"] = { fg = p.blue },
            ["@punctuation.special"] = { fg = p.comment }, -- for mardown list symbols and stuff

            TelescopeBorder = { fg = p.hard_bg, bg = p.hard_bg },
            TelescopePromptCounter = { fg = p.fg, bg = p.softer_bg },
            TelescopePromptBorder = { fg = p.softer_bg, bg = p.softer_bg },
            TelescopePromptNormal = { fg = p.fg, bg = p.softer_bg },
            TelescopePromptPrefix = { fg = p.cyan, bg = p.softer_bg },
            TelescopeNormal = { bg = p.hard_bg },
            TelescopePreviewTitle = { fg = p.bg, bg = p.green.dim },
            TelescopePromptTitle = { fg = p.bg, bg = p.yellow },
            TelescopeResultsTitle = { fg = p.hard_bg, bg = p.fg },

            -- latex:
            Conceal = { fg = p.magenta },

            IndentBlanklineIndent0 = { bg = p.hard_bg, style = "nocombine" },
            IndentBlanklineIndent1 = { bg = p.bg, style = "nocombine" },
        },
    },
})

fox.compile()

local ok, _ = pcall(vim.cmd.colorscheme, colorscheme)
if not ok then
    return
end

if colorscheme == "dayfox" then
    vim.cmd("highlight codeBlockBackground guibg=#dbdbdb")
else
    vim.cmd("highlight codeBlockBackground guibg=#242424")
end