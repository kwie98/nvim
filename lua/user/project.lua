local status_ok, project = pcall(require, "project_nvim")
if not status_ok then
    return
end
project.setup({
    manual_mode = false,
    detection_methods = { "pattern" },
    patterns = {
        ">Python",
        ".git",
        -- "_darcs",
        -- ".hg",
        -- ".bzr",
        -- ".svn",
        -- "Makefile",
        -- "package.json",
    },
    ignore_lsp = {},
    show_hidden = false,
    silent_chdir = false,
    datapath = vim.fn.stdpath("data"),
})

local tele_status_ok, telescope = pcall(require, "telescope")
if not tele_status_ok then
    return
end

telescope.load_extension("projects")
