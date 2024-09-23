vim.loader.enable()

require("kwie.options")
require("kwie.keys")

if not vim.g.vscode then
    require("kwie.lazy")
    require("kwie.autocommands")
end
