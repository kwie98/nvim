local C = require("nightfox.lib.color")
local S = require("nightfox.lib.shade")

local M = {}

local strong = 0.15
local weak = -0.15
M.colors = {
    hard_bg = "#1d2021",
    bg = "#282828",
    soft_bg = "#32302f",
    softer_bg = "#3c3836",
    softest_bg = "#7c6f64",
    softer_fg = "#bdae93",
    soft_fg = "#d5c4a1",
    fg = "#ebdbb2",
    hard_fg = "#fbf1c7",
    black = S.new("#0d0e0f", strong, weak),
    red = S.new("#fb4934", strong, weak),
    signal_red = S.new("#cc241d", strong, weak),
    green = S.new("#98971a", strong, weak),
    yellow = S.new("#eebd35", strong, weak),
    bright_yellow = S.new("#fabd2f", strong, weak),
    blue = S.new("#458588", strong, weak),
    bright_blue = S.new("#7fa2ac", strong, weak),
    magenta = S.new("#b16286", strong, weak),
    clean_green = S.new("#8ec07c", strong, weak),
    forest_green = S.new("#689d6a", strong, weak),
    white = S.new("#dedede", strong, weak),
    orange = S.new("#d65d0e", strong, weak),
    pink = S.new("#d4879c", strong, weak),
    cyan = S.new("#83a598", strong, weak),
    gray = S.new("#504945", strong, weak),
    milk = S.new("#e7d7ad", strong, weak),
    comment = "#665c54",
    -- sel0 = "", -- cmp bg
    -- sel1 = "", -- cmp selected, scroll bg
}

M.palette = {
    black = M.colors.black,
    red = M.colors.red,
    green = M.colors.clean_green,
    yellow = M.colors.yellow,
    blue = M.colors.blue,
    magenta = M.colors.magenta,
    cyan = M.colors.cyan,
    white = M.colors.white,
    orange = M.colors.orange,
    pink = M.colors.pink,
    comment = M.colors.comment,
    bg0 = M.colors.hard_bg,
    bg1 = M.colors.bg,
    bg2 = M.colors.soft_bg,
    bg3 = M.colors.softer_bg,
    bg4 = M.colors.softest_bg,
    fg0 = M.colors.hard_fg,
    fg1 = M.colors.fg,
    fg2 = M.colors.soft_fg,
    fg3 = M.colors.softer_fg,
    sel0 = M.colors.soft_bg,
    sel1 = M.colors.softer_bg,
}
M.diag = {
    error = M.colors.signal_red,
    warn = M.colors.yellow,
    info = M.colors.blue,
    hint = M.colors.forest_green,
}
M.diag_bg = {
    error = C(M.colors.bg):blend(C(M.diag.error.base), 0.15):to_css(),
    warn = C(M.colors.bg):blend(C(M.diag.warn.base), 0.15):to_css(),
    info = C(M.colors.bg):blend(C(M.diag.info.base), 0.15):to_css(),
    hint = C(M.colors.bg):blend(C(M.diag.hint.base), 0.15):to_css(),
}
M.git = {
    add = M.colors.forest_green,
    removed = M.colors.yellow,
    changed = M.colors.blue,
    conflict = M.colors.orange,
    ignored = M.colors.comment,
}
M.diff = {
    add = C(M.colors.bg):blend(C(M.git.add.base), 0.25):to_css(),
    delete = C(M.colors.bg):blend(C(M.git.removed.base), 0.25):to_css(),
    change = C(M.colors.bg):blend(C(M.git.changed.base), 0.25):to_css(),
    text = C(M.colors.bg):blend(C(M.git.changed.base), 0.25):to_css(),
}

-- M.keyword = {
--     flow = dark_colors.red,
--     defs = dark_colors.red.bright,
-- }
-- M.type = dark_colors.clean_green

return M
