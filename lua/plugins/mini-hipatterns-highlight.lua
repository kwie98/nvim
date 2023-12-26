return {
    "echasnovski/mini.hipatterns",
    event = "VeryLazy",

    config = function()
        local hipatterns = require("mini.hipatterns")

        hipatterns.setup({
            highlighters = {
                todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "@text.todo" },
                note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "@text.note" },
                hex_color = hipatterns.gen_highlighter.hex_color(),
            },
        })
    end,
}
