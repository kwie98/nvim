return {
    "rest-nvim/rest.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    lazy = true, -- loaded by after/ftplugin/http
    enabled = false,

    config = function()
        require("rest-nvim").setup({
            result = {
                formatters = {
                    json = function(body) return vim.fn.system({ "prettier", "--parser", "json" }, body) end,
                    html = function(body) return vim.fn.system({ "prettier", "--parser", "html" }, body) end,
                },
            },
        })
    end,
}
