U.load({ "gruvbox-baby.colors", "nightfox" }, function(gruvbox_baby_colors, fox)
    local colorscheme = "fox"
    -- local colorscheme = "gruvbox-baby"
    local background = "light"
    -- vim.opt.background = "dark"

    if colorscheme == "gruvbox-material" then
        vim.g.gruvbox_material_palette = "original"
        vim.g.gruvbox_material_background = "medium"
        vim.g.gruvbox_material_enable_italic = 1
        vim.g.gruvbox_material_disable_italic_comment = 0
        vim.g.gruvbox_material_enable_bold = 1
        vim.g.gruvbox_material_sign_column_background = "none"
        vim.g.gruvbox_material_ui_contrast = "high"
        vim.g.gruvbox_material_statusline_style = "original"
        vim.g.gruvbox_material_disable_terminal_colors = 1
    elseif colorscheme == "gruvbox-baby" then
        local colors = gruvbox_baby_colors.config()
        colors.custom = {
            split = "#504945",
            -- https://mdigi.tools/color/
            diff = {
                --     #26332c
                add = "#13462b",
                --        #273842
                change = "#133d55",
                --        #572e33
                delete = "#6e1722",
            },
        }
        vim.g.gruvbox_baby_background_color = "medium"
        vim.g.gruvbox_baby_use_original_palette = false
        vim.g.gruvbox_baby_highlights = {
            -- GitSignsAdd = { bg = colors.medium_gray, fg = colors.custom.diff.add, style = "bold" },
            -- GitSignsChange = { bg = colors.medium_gray, fg = colors.custom.diff.change, style = "bold" },
            -- GitSignsDelete = { bg = colors.medium_gray, fg = colors.custom.diff.delete, style = "bold" },
            GitSignsAddNr = { fg = colors.comment, bg = colors.diff.add, style = "bold" },
            GitSignsChangeNr = { fg = colors.comment, bg = colors.diff.change, style = "bold" },
            GitSignsDeleteNr = { fg = colors.comment, bg = colors.diff.delete, style = "bold" },
            DiffAdd = { bg = colors.diff.add }, -- removes syntax highlighting
            DiffChange = { bg = colors.diff.change }, -- removes syntax highlighting
            DiffDelete = { bg = colors.diff.delete }, -- removes syntax highlighting
            VertSplit = { fg = colors.custom.split },
            LineNr = { fg = colors.custom.split, style = "bold" },
        }
        vim.g.gruvbox_baby_telescope_theme = 1
    elseif colorscheme == "fox" then
        if background == "light" then
            colorscheme = "dayfox"
        else
            colorscheme = "terafox"
        end
        require("nightfox").setup({
            -- dim_inactive = true,
            options = {
                styles = {
                    comments = "italic",
                    functions = "bold",
                    types = "italic",
                },
            },
        })
    end

    -- vim.opt.background = background
    -- vim.cmd.colorscheme(colorscheme)
    local ok, _ = pcall(vim.cmd.colorscheme, colorscheme)
    if not ok then
        return
    end

    -- vim.cmd([[
    --     try
    --         " colorscheme gruvbox-material
    --         colorscheme gruvbox-baby
    --     catch /^Vim\%((\a\+)\)\=:E185/
    --         colorscheme default
    --     endtry
    -- ]])
end)
