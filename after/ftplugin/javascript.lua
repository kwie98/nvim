vim.bo.commentstring = "// %s"
-- vim.keymap.set("n", "<Leader>rr", "<CMD>!node %<Enter>", { buffer = true, silent = true, desc = "Run File" })
-- vim.keymap.set("n", "<Leader>le", function()
--     -- TODO: read SRC and DIST from tsconfig.json
--     local SRC = "src"
--     local DIST = "dist"
--     -- local current = vim.fn.expand("%:p")
--     -- local git_path = vim.fn.finddir(".git", ".;")
--     -- if git_path ~= "" then
--     --     local project_root = vim.fn.fnamemodify(git_path, ":p:h:h")
--     --     local compiled = nil
--     -- end
--     local current = vim.fn.expand("%:r")
--     local compiled = string.gsub(current, DIST, SRC) .. ".ts"
--     vim.cmd.edit(compiled)
-- end, { buffer = true, silent = true, desc = "Goto Compiled Javascript" })
