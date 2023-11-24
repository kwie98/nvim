return {
    "dstein64/nvim-scrollview",
    event = "VeryLazy",

    config = function()
        local scrollview = require("scrollview")

        scrollview.setup({
            excluded_filetypes = {
                "prompt",
                "TelescopePrompt",
                "fugitive",
                "gitcommit",
                "dapui_scopes",
                "dapui_watches",
                "dapui_stacks",
                "dap-repl",
                "dapui_console",
                "NvimTree",
            },
            signs_on_startup = {},
        })
    end,
}
