vim.opt_local.conceallevel = 1
vim.opt_local.concealcursor = "nc"
vim.opt_local.wrap = true
vim.opt_local.breakindent = true
vim.opt_local.breakindentopt = "shift:2"
-- vim.bo.wrap = true
vim.keymap.set("n", "<Leader>rr", "<CMD>MarkdownPreview<Enter>", { buffer = true, silent = true, desc = "Preview" })
-- vim.keymap.set("n", "<Enter>", require("telekasten").toggle_todo, { buffer = true, silent = true })
-- vim.keymap.set("n", "<Tab>", "/[[\\zs<Enter>", { buffer = true, silent = true })
-- vim.keymap.set("n", "<S-Tab>", "?[[\\zs<Enter>", { buffer = true, silent = true })

vim.cmd([[
    call ColorCodeBlocks()
]])
