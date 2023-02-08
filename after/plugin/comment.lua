local comment = require("Comment")

comment.setup({
    ignore = "^$",
    toggler = {
        line = "gcc",
        block = "gbc",
    },
    sticky = false,
    opleader = {
        line = "gc",
        block = "gb",
    },
    extra = {
        above = "gcO",
        below = "gco",
        eol = "gcA",
    },
    mappings = {
        basic = true,
        extra = true,
        extended = false,
    },
    pre_hook = function(ctx)
        local cutils = require("Comment.utils")

        local location = nil
        if ctx.ctype == cutils.ctype.blockwise then
            location = require("ts_context_commentstring.utils").get_cursor_location()
        elseif ctx.cmotion == cutils.cmotion.v or ctx.cmotion == cutils.cmotion.V then
            location = require("ts_context_commentstring.utils").get_visual_start_location()
        end

        return require("ts_context_commentstring.internal").calculate_commentstring({
            key = ctx.ctype == cutils.ctype.linewise and "__default" or "__multiline",
            location = location,
        })
    end,
})
