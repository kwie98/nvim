return {
    root_dir = require("lspconfig.util").find_git_ancestor,
    settings = {
        python = {
            analysis = {
                stubPath = "/home/konrad/Documents/projects/Python/python-type-stubs",
                typeCheckingMode = "strict",
                useLibraryCodeForTypes = true,
                diagnosticSeverityOverrides = {
                    reportMissingTypeStubs = "warning",
                    -- reportUnknownArgumentType = "none",
                    -- reportUnknownLambdaType = "none",
                    -- removes warning about np.arange type being partially unknown:
                    reportUnknownMemberType = "none",
                    -- reportUnknownParameterType = "none",
                    reportUnknownVariableType = "none",
                },
            },
        },
    },
}
