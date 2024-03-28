-- This file should be sourced after configuring tokyonight or by a darkman hook.

-- Query system color scheme (~8ms):
local background = vim.trim(vim.fn.system("darkman get"))

if background ~= "dark" then
    vim.opt.background = "light"
    pcall(vim.cmd.colorscheme, "tokyonight-day")
else -- could be "dark" or something else (if darkman fails)
    vim.opt.background = "dark"
    pcall(vim.cmd.colorscheme, "tokyonight-night")
end
