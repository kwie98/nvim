if not vim.g.vscode then
    vim.loader.enable()
    require("kwie.options")
    require("kwie.lazy")
    require("kwie.keys")
    require("kwie.autocommands")
end
