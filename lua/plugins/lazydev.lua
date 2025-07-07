---@module "lazydev"
---@type LazySpec
return {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    ---@type lazydev.Config
    opts = {
        library = { "lazy.nvim" },
    },
}
