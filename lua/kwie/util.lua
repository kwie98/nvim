local M = {}

---@param name string
M.augroup = function(name) return vim.api.nvim_create_augroup("kwie_" .. name, { clear = true }) end

---Split a string by whitespace, put into table
---@param s string
---@return table
M.words = function(s)
    local words = {}
    for word in s:gmatch("%S+") do
        table.insert(words, word)
    end
    return words
end

return M
