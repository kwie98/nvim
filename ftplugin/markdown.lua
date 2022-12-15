vim.keymap.set("n", "<Leader>x", "<CMD>MarkdownPreview<CR>", { buffer = true, silent = true, desc = "Preview" })
vim.keymap.set("n", "<C-Space>", "<CMD>Telekasten toggle_todo<CR>", { buffer = true, silent = true })
-- vim.keymap.set("n", "<Enter>", "<CMD>Telekasten follow_link<CR>", { buffer = true, silent = true, desc = "" })
vim.keymap.set("n", "<Enter>", "<CMD>Telescope lsp_definitions theme=ivy<CR>", { buffer = true, silent = true })
vim.keymap.set("n", "<Tab>", "/[[\\zs<CR>", { buffer = true, silent = true })
vim.keymap.set("n", "<S-Tab>", "?[[\\zs<CR>", { buffer = true, silent = true })

-- vim.wo.wrap = true
-- vim.bo.spell = true
vim.bo.textwidth = 100
vim.bo.shiftwidth = 2
vim.bo.tabstop = 2

vim.cmd([[
    call ColorCodeBlocks()
]])
