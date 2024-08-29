return {
    "sindrets/diffview.nvim",
    lazy = true, -- loaded by telescope/advanced git search

    config = function()
        local diffview = require("diffview")
        diffview.setup({
            enhanced_diff_hl = true,
            hooks = {
                -- view_opened = function(view) print(vim.inspect(view)) end
                diff_buf_read = function() vim.keymap.set("n", "<Leader>c", diffview.close, { buffer = true }) end,
            },
        })

        vim.keymap.set("n", "<Leader>gs", diffview.open, { desc = "Status" })
        vim.keymap.set("n", "<Leader>gh", diffview.file_history, { desc = "History" })
        vim.keymap.set(
            "n",
            "<Leader>gf",
            function() diffview.file_history(nil, { "%" }) end,
            { desc = "History of this File" }
        )
    end,
}
