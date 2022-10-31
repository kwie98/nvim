return {
    settings = {
        python = {
            analysis = {
                stubPath = "typings",
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
