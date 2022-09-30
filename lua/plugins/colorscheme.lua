vim.g.gruvbox_material_palette = "original"
vim.g.gruvbox_material_background = "hard"
vim.g.gruvbox_material_enable_italic = 1
vim.g.gruvbox_material_disable_italic_comment = 0
vim.g.gruvbox_material_enable_bold = 1
vim.g.gruvbox_material_sign_column_background = "none"
vim.g.gruvbox_material_ui_contrast = "high"
vim.g.gruvbox_material_statusline_style = "original"
vim.g.gruvbox_material_disable_terminal_colors = 1

vim.cmd([[
    try
        colorscheme gruvbox-material
    catch /^Vim\%((\a\+)\)\=:E185/
        colorscheme default
        set background=dark
    endtry
]])
