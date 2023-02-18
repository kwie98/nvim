return {
    {
        "iamcco/markdown-preview.nvim",
        build = "cd app && npm install",
        lazy = true,
        cmd = {
            "MarkdownPreview",
            "MarkdownPreviewStop",
            "MarkdownPreviewToggle",
        },
        ft = "markdown",
        keys = {
            { "<Leader>x", mode = "n" },
        },

        config = function()
            vim.g.mkdp_filetypes = { "markdown", "vimwiki" }
            vim.g.mkdp_auto_start = 0
            vim.g.mkdp_command_for_global = 1
            vim.g.mkdp_page_title = "${name}.md"
            vim.g.mkdp_theme = "light"
            vim.g.mkdp_auto_close = 0
        end,
    },
}
