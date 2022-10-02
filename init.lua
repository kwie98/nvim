if not vim.g.vscode then
    require("core.options")
    require("core.keymaps")
    require("core.packer")
    require("core.lsp")

    require("plugins")
end
