vim.keymap.set("n", "<Enter>", "<C-]>", { buffer = true })

local move = require("nvim-treesitter.textobjects.move")
vim.keymap.set("n", "<Tab>", function()
    move.goto_next_start("@link")
end, { buffer = true })
vim.keymap.set("n", "<S-Tab>", function()
    move.goto_previous_start("@link")
end, { buffer = true })

vim.keymap.set("n", "]]", function()
    move.goto_next_start("@header")
end, { buffer = true })
vim.keymap.set("n", "[[", function()
    move.goto_previous_start("@header")
end, { buffer = true })

vim.wo.colorcolumn = ""
