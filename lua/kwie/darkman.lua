-- query system color scheme (~8ms)
local background = vim.trim(vim.fn.system("darkman get"))
local colorscheme = "tokyonight-night" -- default
if background == "dark" or background == "light" then
    vim.opt.background = background
    if background == "light" then
        colorscheme = "tokyonight-day"
        -- Moon is a bit darker and has some different hl groups and colors, night is quite dark and contrasty
    end

    pcall(vim.cmd.colorscheme, colorscheme)
    pcall(vim.cmd.colorscheme, colorscheme) -- helps with bufferline highlights
else
    pcall(vim.cmd.colorscheme, colorscheme)
end
