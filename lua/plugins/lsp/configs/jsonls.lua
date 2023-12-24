return {
    -- LazyVim: Lazy-load custom schemastore:
    on_new_config = function(new_config)
        new_config.settings.json.schemas = new_config.settings.json.schemas or {}
        vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
    end,
    settings = {
        json = {
            format = { enable = false },
            -- schemas = schemastore.json.schemas(),
            validate = { enable = true },
        },
    },
}
