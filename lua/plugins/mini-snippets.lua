return {
    "echasnovski/mini.snippets",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
        local snippets = require("mini.snippets")

        snippets.setup({
            snippets = { snippets.gen_loader.from_lang() },
        })

        vim.api.nvim_set_hl(0, "MiniSnippetsFinal", { link = "SnippetTabstop" })
        vim.api.nvim_set_hl(0, "MiniSnippetsCurrent", { link = "SnippetTabstop" })
        vim.api.nvim_set_hl(0, "MiniSnippetsVisited", { link = "SnippetTabstop" })
        vim.api.nvim_set_hl(0, "MiniSnippetsUnvisited", { link = "SnippetTabstop" })
        vim.api.nvim_set_hl(0, "MiniSnippetsCurrentReplace", { link = "SnippetTabstop" })

        -- vim.api.nvim_create_autocmd("TextChanged", {
        vim.api.nvim_create_autocmd("InsertLeave", {
            group = require("kwie.util").augroup("stop_snippets"),
            callback = function() snippets.session.stop() end,
        })
    end,
}
