local project = require("project_nvim")
local telescope = require("telescope")

project.setup({
    manual_mode = false,
    detection_methods = { "pattern" },
    -- patterns = { ">Python", ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" },
    patterns = { ".git" }, -- ">"-patterns break fugitive sadly
    ignore_lsp = {},
    show_hidden = false,
    silent_chdir = true,
    datapath = vim.fn.stdpath("data"),
})

vim.keymap.set("n", "<Leader>j", telescope.extensions.projects.projects, { desc = "Projects" })
