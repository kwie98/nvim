vim.keymap.set("n", "<Leader>x", "<CMD>!python %<CR>", { buffer = true, silent = true, desc = "Execute File" })
local telescope = require("telescope")
vim.keymap.set(
    "n",
    "<Leader>le",
    telescope.extensions.conda.conda,
    { buffer = true, silent = true, desc = "Environments" }
)
