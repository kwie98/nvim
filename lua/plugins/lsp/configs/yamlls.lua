return {
    -- LazyVim: Lazy-load custom schemastore:
    on_new_config = function(new_config)
        new_config.settings.yaml.schemas =
            vim.tbl_deep_extend("force", new_config.settings.yaml.schemas or {}, require("schemastore").yaml.schemas())
    end,
    settings = {
        redhat = { telemetry = { enabled = false } },
        yaml = {
            format = { enable = false },
            hover = true,
            completion = true,
            validate = true,
            -- LazyVim: Must disable built-in schemaStore support to use schemas from plugin:
            schemaStore = { enable = false, url = "" },
        },
    },
}
