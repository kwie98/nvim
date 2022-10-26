local U = {}

---Tries to load the given modules. If at least one cannot be loaded, an error is printed and nothing else is done.
---Otherwise, run the given function with the modules as parameters
---@param module_names table
---@param func any
---@return unknown
U.load = function(module_names, func)
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
    return func(unpack(modules))
end

---Helper function to check whether a string starts with a prefix
---@param string string The string to check
---@param prefix string The prefix
---@return boolean
U.string_starts = function(string, prefix)
    return string.sub(string, 1, string.len(prefix)) == prefix
end

U.modified_icon = "" -- for bufferline, lualine
U.small_border = "single" -- smaller helper floats
U.big_border = "shadow" -- ui window floats

return U
