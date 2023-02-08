local project = require("project_nvim")

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
