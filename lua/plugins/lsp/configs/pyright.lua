return {
    root_dir = require("lspconfig.util").find_git_ancestor,
    settings = {
        python = {
            analysis = {
                diagnosticMode = "workspace",
                -- stubPath = "/home/konrad/.local/share/python-type-stubs/stubs/",
            },
        },
    },
}
