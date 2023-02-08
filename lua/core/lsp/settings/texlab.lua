return {
    settings = {
        texlab = {
            build = {
                executable = "tectonic",
                args = { "%f", "--synctex", "--keep-logs", "--keep-intermediates" },
                forwardSearchAfter = false,
                onSave = true,
            },
            chktex = {
                onEdit = false,
                onOpenAndSave = false,
            },
            forwardSearch = {
                executable = "zathura",
                args = { "--synctex-forward", "%l:1:%f", "%p" },
            },
            -- forwardSearch = {
            --     executable = "okular",
            --     args = { "--unique", "file:%p#src:%l%f" },
            -- },
            latexFormatter = "texlab",
        },
    },
}
