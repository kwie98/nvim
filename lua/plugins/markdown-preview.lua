return {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install && rm -f package-lock.json && git restore .",
    -- cmd = {
    --     "MarkdownPreview",
    --     "MarkdownPreviewStop",
    --     "MarkdownPreviewToggle",
    -- },
    ft = "markdown",

    config = function()
        vim.g.mkdp_filetypes = { "markdown" }
        vim.g.mkdp_auto_start = 0
        vim.g.mkdp_command_for_global = 1
        vim.g.mkdp_page_title = "${name}.md"
        -- vim.g.mkdp_theme = "light"
        vim.g.mkdp_auto_close = 0
        -- vim.g.mkdp_images_path = vim.g.wiki_folder .. "img/"
    end,
}
