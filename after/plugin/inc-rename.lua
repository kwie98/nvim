require("inc_rename").setup()

vim.keymap.set("n", "<leader>lr", function()
    return ":IncRename " .. vim.fn.expand("<cword>")
end, { desc = "Rename", expr = true })
