vim.keymap.set("n", "<Leader>x", "<CMD>MarkdownPreview<CR>", { buffer = true, silent = true, desc = "Preview" })
vim.keymap.set("n", "<Leader><Leader>", require("telekasten").toggle_todo, { buffer = true, silent = true })
vim.keymap.set("n", "<Tab>", "/[[\\zs<CR>", { buffer = true, silent = true })
vim.keymap.set("n", "<S-Tab>", "?[[\\zs<CR>", { buffer = true, silent = true })
vim.keymap.set("n", "<Enter>", require("telescope.builtin").lsp_definitions, { buffer = true, desc = "Goto Definition" })

-- vim.wo.wrap = true
-- vim.bo.spell = true
vim.bo.textwidth = 80
vim.bo.shiftwidth = 2
vim.bo.tabstop = 2

vim.cmd([[
    call ColorCodeBlocks()
]])
