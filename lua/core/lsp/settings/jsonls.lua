return U.load({ "schemastore" }, function(schemastore)
    return {
        settings = {
            json = {
                schemas = schemastore.json.schemas(),
                validate = {
                    enable = true,
                },
            },
        },
        -- setup = {
        --     commands = {
        --         Format = {
        --             function()
        --                 vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line("$"), 0 })
        --             end,
        --         },
        --     },
        -- },
    }
end)
