if not vim.g.vscode then
    require("core.options")
    require("core.keymaps")
    require("core.packer")
    require("plugins.colorscheme")
    require("plugins.cmp")
    require("core.lsp")
    require("plugins.telescope")
    require("plugins.treesitter")
    require("plugins.autopairs")
    require("plugins.comment")
    require("plugins.gitsigns")
    require("plugins.nvim-tree")
    require("plugins.bufferline")
    require("plugins.lualine")
    require("plugins.toggleterm")
    require("plugins.project")
    require("plugins.impatient")
    -- require("plugins.indentline")
    require("plugins.whichkey")
    require("plugins.autocommands")

    require("plugins.colorizer")
    -- require("plugins.vimwiki")
    require("plugins.telekasten")
    require("plugins.markdown-preview")
    require("plugins.dap")
    require("plugins.lsp-signature")
    require("plugins.illuminate")
    require("plugins.harpoon")
    require("plugins.matchup")
end
