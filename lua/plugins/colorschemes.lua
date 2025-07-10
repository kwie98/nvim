---@param name string
---@param base string
---@param val table
local function update_hl(name, base, val)
    local old = vim.api.nvim_get_hl(0, { name = base })
    local new = vim.tbl_extend("force", old, val)
    vim.api.nvim_set_hl(0, name, new)
end
return {
    {
        "zenbones-theme/zenbones.nvim",
        dependencies = { "rktjmp/lush.nvim" },
        priority = 100,
        init = function()
            -- vim.g.zenbones_italic_strings = false
            -- vim.g.zenwritten_italic_strings = false
            vim.g.zenbones_lightness = "bright"
            vim.g.zenwritten_lightness = "bright"
        end,
        config = function()
            vim.cmd.colorscheme("zenbones")
            vim.api.nvim_set_hl(0, "@none", { nocombine = true }) -- reest italic hl of string in f-string brackets
            vim.api.nvim_set_hl(0, "@lsp.type.decorator.markdown", { italic = true, bold = true, fg = "#556570" })
            -- vim.api.nvim_set_hl(0, "@property.yaml", { nocombine = true , force=true})
            update_hl("@property.yaml", "Identifier", { nocombine = true })
            -- vim.api.nvim_set_hl(0, "FzfLuaFzfMarker", { fg="#00ff00", bg = "#ff0000" })
        end,
    },
    -- {
    --     "echasnovski/mini.colors",
    --     config = function() require("mini.colors").setup() end,
    -- },
    -- -- {
    -- --     "lunacookies/vim-colors-xcode",
    -- --     enabled = true,
    -- --     lazy = false,
    -- --     priority = 1000,
    -- --     config = function()
    -- --         -- Set to 1 to emphasise types over functions and identifiers. The default is 1.
    -- --         vim.g.xcode_emph_types = 1
    -- --         -- Set to 1 to emphasise functions over types and identifiers. The default is 0.
    -- --         vim.g.xcode_emph_funcs = 0
    -- --         -- Set to 1 to emphasise identifiers over types and functions. The default is 0.
    -- --         vim.g.xcode_emph_idents = 0
    -- --         -- Set to 0 to use the UI’s blue colour for matching surrounds (e.g. parentheses),
    -- --         -- or set to 1 to use Xcode’s original yellow colour, which may cause confusion
    -- --         -- with the cursor. The default is 0.
    -- --         vim.g.xcode_match_paren_style = 1
    -- --         -- Set to 1 to dim punctuation (Delimiters and Operators). The default is 1.
    -- --         vim.g.xcode_dim_punctuation = 1
    -- --         vim.cmd.colorscheme("xcode")
    -- --         -- vim.cmd("colorscheme xcode")
    -- --     end,
    -- -- },
    -- {
    --     "projekt0n/github-nvim-theme",
    --     enabled = true,
    -- },
    -- {
    --     "olivercederborg/poimandres.nvim",
    --     enabled = true,
    --
    --     config = function() require("poimandres").setup() end,
    -- },
    -- {
    --     "loganswartz/polychrome.nvim",
    -- },
}
