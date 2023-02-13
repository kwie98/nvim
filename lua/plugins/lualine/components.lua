local M = {}

local function hide_in_width()
    return vim.fn.winwidth(0) > 60
end

M.diff = {
    "diff",
    colored = false,
    padding = { left = 0, right = 1 },
    cond = hide_in_width,
}

M.treesitter = {
    function()
        local buf = vim.api.nvim_get_current_buf()
        local ts = vim.treesitter.highlighter.active[buf]
        if ts and not vim.tbl_isempty(ts) then
            return ""
        else
            return ""
        end
    end,
    cond = hide_in_width,
}

M.lsp = {
    function(msg)
        msg = msg or "LS Inactive"
        local buf_clients = vim.lsp.get_active_clients()
        if next(buf_clients) == nil then
            if type(msg) == "boolean" or #msg == 0 then
                return "LS Inactive"
            end
            return msg
        end
        local buf_client_names = {}

        -- add client
        for _, client in pairs(buf_clients) do
            if client.name ~= "null-ls" then
                table.insert(buf_client_names, client.name)
            end
        end

        if #buf_client_names == 0 then
            return ""
        end

        local unique_client_names = vim.fn.uniq(buf_client_names)
        return table.concat(unique_client_names, ", ")
    end,
    cond = hide_in_width,
    padding = { left = 0, right = 1 },
}

M.python_env = {
    function()
        if vim.bo.filetype == "python" then
            local venv = os.getenv("CONDA_DEFAULT_ENV")
            if venv then
                return string.format("(%s)", venv)
            end
            venv = os.getenv("VIRTUAL_ENV")
            if venv then
                return string.format(" %s", venv)
            end
            return ""
        end
        return ""
    end,
    padding = { left = 0, right = 1 },
    cond = hide_in_width,
}

return M
