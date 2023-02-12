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
    },
})
-- local scrollbar = require("scrollbar")

-- scrollbar.setup({
--     show_in_active_only = true,
--     excluded_filetypes = {
--         "prompt",
--         "TelescopePrompt",
--         "fugitive",
--         "gitcommit",
--         "dapui_scopes",
--         "dapui_watches",
--         "dapui_stacks",
--         "dap-repl",
--         "dapui_console",
--     },
--     handlers = {
--         cursor = false,
--         diagnostic = false,
--         search = false,
--     },
-- })
