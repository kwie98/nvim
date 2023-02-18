local function trim(s)
    return (s:gsub("^%s*(.-)%s*$", "%1"))
end

-- query system color scheme (~8ms)
local background = trim(vim.fn.system("darkman get"))
vim.opt.background = background
local colorscheme
if background == "light" then
    colorscheme = "tokyonight-day"
else
    -- moon is a bit darker and has some different hl groups and colors, night is quite dark and contrasty
    colorscheme = "tokyonight-night"
end

pcall(vim.cmd.colorscheme, colorscheme)
pcall(vim.cmd.colorscheme, colorscheme) -- helps with bufferline highlights
