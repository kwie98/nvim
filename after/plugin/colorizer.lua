local colorizer = require("colorizer")

colorizer.setup({
    filetypes = { "*", "!packer" },
    user_default_options = {
        names = false,
    },
})
