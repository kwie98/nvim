return {
    "neovim/nvim-lspconfig",
    dependencies = { "b0o/schemastore.nvim" },
    keys = {
        {"grI", vim.cmd.LspInfo, desc = "LSP Info"}, -- TODO
        {"grR", vim.cmd.LspRestart, desc = "Restart LSP"},
    },
    -- event = "VeryLazy"
    lazy = false,
}
