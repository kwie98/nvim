vim.loader.enable()

vim.cmd.abbreviate("nda", "NDArray[Any]")
vim.cmd.abbreviate("ndb", "NDArray[np.bool_]")
vim.cmd.abbreviate("ndf", "NDArray[np.float32]")

require("kwie.options")
require("kwie.keys")

if not vim.g.vscode then
    require("kwie.lazy")
    require("kwie.autocommands")
end
