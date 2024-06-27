-- This file should be sourced after configuring tokyonight or by a darkman hook.

-- Query system color scheme (~8ms):
local background = vim.trim(vim.fn.system("darkman get"))

if background == "dark" then
    vim.opt.background = "dark"
    pcall(vim.cmd.colorscheme, "tokyonight-night")
else
    vim.opt.background = "light"
    pcall(vim.cmd.colorscheme, "tokyonight-day")
end
