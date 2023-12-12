-- This file is run after configuring tokyonight or by a darkman hook.

-- Query system color scheme (~8ms):
local background = vim.trim(vim.fn.system("darkman get"))

if background == "dark" then
    vim.opt.background = background
    pcall(vim.cmd.colorscheme, "tokyonight-night")
elseif background == "light" then
    vim.opt.background = background
    pcall(vim.cmd.colorscheme, "tokyonight-day")
else
    print("Got unexpected darkman answer: " .. background)
end
