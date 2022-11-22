local scrollbar = require("scrollbar")

scrollbar.setup({
    show_in_active_only = true,
    excluded_filetypes = { "prompt", "TelescopePrompt", "fugitive", "gitcommit" },
    handlers = {
        cursor = false,
        diagnostic = false,
        search = false,
    },
    -- handle = {
    --     highlight = "Cursor",
    -- },
})
