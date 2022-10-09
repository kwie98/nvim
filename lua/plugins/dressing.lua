local status_ok, dressing = pcall(require, "dressing")
if not status_ok then
    print("Could not load colorizer.")
    return
end

dressing.setup({
    input = {
        anchor = "NW",
        border = U.small_border,
        override = function(conf)
            -- row = 3
            -- col = 3
            conf.row = -3
            conf.col = -2
            return conf
        end,
        winblend = 0,
    },
})
