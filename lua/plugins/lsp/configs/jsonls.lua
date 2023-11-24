local schemastore = require("schemastore")
return {
    settings = {
        json = {
            format = {
                enable = false,
            },
            schemas = schemastore.json.schemas(),
            validate = {
                enable = true,
            },
        },
    },
}
