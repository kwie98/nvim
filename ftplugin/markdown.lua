vim.keymap.set("n", "<Leader>x", "<CMD>MarkdownPreview<CR>", { buffer = true })
vim.keymap.set("n", "<C-Space>", "<CMD>Telekasten toggle_todo<CR>", { buffer = true })
-- vim.keymap.set("v", "<C-Space>", ":Telekasten toggle_todo | norm! gv<CR>", { buffer = true })

vim.opt.wrap = true
vim.opt.spell = true
vim.opt.textwidth = 100
vim.opt.colorcolumn = "101"
