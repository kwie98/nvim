local M = {}

M.load = function(module_name)
    local ok, module = pcall(require, module_name)
    if not ok then
        print("Could not load module: " .. module_name)
        return
    end
    return module
end

return M
