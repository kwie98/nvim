return {
    "echasnovski/mini.bufremove",
    keys = { { "<Leader>cb", function() require("mini.bufremove").delete() end, desc = "Close Buffer" } },

    opts = {},
}
