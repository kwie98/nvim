return {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    -- dependencies = { "nvim-tree/nvim-web-devicons" },
    -- or if using mini.icons/mini.nvim
    -- dependencies = { "echasnovski/mini.icons" },

    config = function ()
        local fzf = require("fzf-lua")
        vim.keymap.set("n", "<Leader>b", fzf.buffers)
        vim.keymap.set("n", "<Leader>f", fzf.files)
        vim.keymap.set("n", "<Leader>t", fzf.live_grep)
        fzf.setup()
    end
}
