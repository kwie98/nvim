local neogit = require("neogit")

neogit.setup({
    disable_context_highlighting = true,
    -- disable_commit_confirmation = true,
    disable_builtin_notifications = true,
    kind = "split",
    commit_popup = {
        kind = "replace",
    },
    signs = {
        section = { "", "" },
        item = { "", "" },
    },
    integrations = {
        diffview = true,
    },
})