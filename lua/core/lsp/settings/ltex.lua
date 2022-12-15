return {
    filetypes = { "bib", "markdown", "org", "plaintex", "rst", "rnoweb", "tex" },
    on_attach = function(client, bufnr)
        require("core.lsp.handlers").on_attach()
        require("ltex_extra").setup({
            load_langs = { "de-DE", "en-US" },
            init_check = true,
            path = ".vscode",
            log_level = "none",
        })
    end,
    settings = {
        ltex = {
            completionEnabled = false,
            additionalRules = {
                enablePickyRules = true,
                motherTongue = "de-DE",
            },
        },
    },
}
