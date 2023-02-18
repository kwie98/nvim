return {
    {
        "michaelb/sniprun",
        build = "bash ./install.sh",
        lazy = true,
        keys = {
            {"<Leader>r", mode="n", desc = "Run Line"},
            {"<Leader>r", mode="x", desc = "Run Selection"},
        },

        config = function ()
            local sniprun = require("sniprun")

            vim.keymap.set({"n", "x"}, "<Leader>r", sniprun.run, {desc="Run Selection"})
        end
    },
}
