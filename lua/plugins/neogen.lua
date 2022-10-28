U.load({ "neogen" }, function(neogen)
    neogen.setup({
        snippet_engine = "luasnip",
        languages = {
            python = {
                template = {
                    annotation_convention = "google_docstrings",
                },
            },
        },
    })
end)
