local status_ok, project = pcall(require, "project_nvim")
if not status_ok then
    print("Could not load project.nvim.")
    return
end
project.setup({
    manual_mode = false,
    detection_methods = { "pattern" },
    -- patterns = { ">Python", ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" },
    patterns = { ".git" }, -- ">"-patterns break fugitive sadly
    ignore_lsp = {},
    show_hidden = false,
    silent_chdir = false,
    datapath = vim.fn.stdpath("data"),
})
