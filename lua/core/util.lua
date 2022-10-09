local M = {}

M.load = function(module_names, func)
    local modules = {}
    for _, module_name in ipairs(module_names) do
        local ok, module = pcall(require, module_name)
        if not ok then
            print("Could not load module: " .. module_name)
            print(debug.traceback())
            return
        else
            table.insert(modules, module)
        end
    end
    func(unpack(modules))
end

M.small_border = "double" -- smaller helper floats
M.big_border = "shadow" -- ui window floats

return M
