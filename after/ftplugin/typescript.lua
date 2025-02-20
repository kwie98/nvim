vim.bo.commentstring = "// %s"
require("nvim-surround").buffer_setup({
    surrounds = {
        ["p"] = {
            add = { "console.log(", ")" },
        },
    },
})
-- local function get_compiled_file()
--     -- TODO: read SRC and DIST from tsconfig.json
--     local SRC = "src"
--     local DIST = "dist"
--     local current = vim.fn.expand("%:r")
--     return string.gsub(current, SRC, DIST) .. ".js"
-- end
-- -- vim.keymap.set("n", "<Leader>x", compile.run_typescript, { buffer = true, silent = true, desc = "Compile and Execute File" })
-- vim.keymap.set(
--     "n",
--     "<Leader>le",
--     function() vim.cmd.edit(get_compiled_file()) end,
--     { buffer = true, silent = true, desc = "Goto Compiled Javascript" }
-- )
