local M = {}

---@param name string
M.augroup = function(name) return vim.api.nvim_create_augroup("kwie_" .. name, { clear = true }) end

return M
