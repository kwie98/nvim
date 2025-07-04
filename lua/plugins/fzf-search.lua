return {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    -- dependencies = { "nvim-tree/nvim-web-devicons" },
    -- or if using mini.icons/mini.nvim
    -- dependencies = { "echasnovski/mini.icons" },

    config = function()
        local fzf = require("fzf-lua")
        vim.keymap.set("n", "<Leader>b", fzf.buffers, { desc = "Search Buffers" })
        vim.keymap.set("n", "<Leader>f", fzf.files, { desc = "Search Files" })
        vim.keymap.set("n", "<Leader>t", fzf.live_grep_native, { desc = "Live Grep" })
        vim.keymap.set("n", "<Leader>sr", function() fzf.oldfiles({cwd="%:p:h"}) end, { desc = "Old Files" })
        vim.keymap.set("n", "<Leader>sh", fzf.helptags, { desc = "Help" })
        vim.keymap.set("n", "<Leader>gs", fzf.git_status, { desc = "Git Status" })
        vim.keymap.set("n", "<Leader>sk", fzf.keymaps, {desc = "Keymaps"})

        fzf.setup()
    end,
}
