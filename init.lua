vim.cmd.abbreviate("nda", "NDArray[Any]")
vim.cmd.abbreviate("ndb", "NDArray[np.bool_]")
vim.cmd.abbreviate("ndf", "NDArray[np.float32]")

if not vim.g.vscode then
    vim.loader.enable()
    require("kwie.options")
    require("kwie.lazy")
    require("kwie.keys")
    require("kwie.autocommands")
end
