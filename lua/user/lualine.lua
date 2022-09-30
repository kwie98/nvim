local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
    return
end

local hide_in_width = function()
    return vim.fn.winwidth(0) > 80
end

local diagnostics = {
    "diagnostics",
    sources = { "nvim_diagnostic" },
    sections = { "error", "warn" },
    symbols = { error = " ", warn = " " },
    colored = false,
    update_in_insert = false,
    always_visible = true,
}

local diff = {
    "diff",
    colored = false,
    symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
    cond = hide_in_width,
}

local python_env = {
    function()
        -- local utils = require "lvim.core.lualine.utils"
        if vim.bo.filetype == "python" then
            local venv = os.getenv("CONDA_DEFAULT_ENV")
            if venv then
                -- return string.format("  (%s)", utils.env_cleanup(venv))
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
    cond = hide_in_width,
}

local treesitter = {
    function()
        return ""
        -- local buf = vim.api.nvim_get_current_buf()
        -- local ts = vim.treesitter.highlighter.active[buf]
        -- if ts and not vim.tbl_isempty(ts) then
        --     return ""
        -- else
        --     return " "
        -- end
    end,
    color = function()
        local buf = vim.api.nvim_get_current_buf()
        local ts = vim.treesitter.highlighter.active[buf]
        return { fg = ts and not vim.tbl_isempty(ts) and "#8EA64C" or nil }
    end,
    cond = hide_in_width,
}

local lsp = {
    function(msg)
        msg = msg or "LS Inactive"
        local buf_clients = vim.lsp.buf_get_clients()
        if next(buf_clients) == nil then
            -- TODO: clean up this if statement
            if type(msg) == "boolean" or #msg == 0 then
                return "LS Inactive"
            end
            return msg
        end
        local buf_ft = vim.bo.filetype
        local buf_client_names = {}

        -- add client
        for _, client in pairs(buf_clients) do
            if client.name ~= "null-ls" then
                table.insert(buf_client_names, client.name)
            end
        end

        -- if #buf_client_names == 0 then
        if #buf_client_names == 0 then
            return "LS Inactive"
        end

        -- add formatter
        -- local formatters = require "lvim.lsp.null-ls.formatters"
        -- local supported_formatters = formatters.list_registered(buf_ft)
        -- vim.list_extend(buf_client_names, supported_formatters)

        -- add linter
        -- local linters = require "lvim.lsp.null-ls.linters"
        -- local supported_linters = linters.list_registered(buf_ft)
        -- vim.list_extend(buf_client_names, supported_linters)

        local unique_client_names = vim.fn.uniq(buf_client_names)
        return "[" .. table.concat(unique_client_names, ", ") .. "]"
    end,
    color = { gui = "bold" },
    cond = hide_in_width,
}

local filetype = {
    "filetype",
    icons_enabled = false,
    icon = nil,
}

local branch = {
    "branch",
    icons_enabled = true,
    icon = "",
}

-- cool function for progress
local progress = function()
    local current_line = vim.fn.line(".")
    local total_lines = vim.fn.line("$")
    local chars = { "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
    local line_ratio = current_line / total_lines
    local index = math.ceil(line_ratio * #chars)
    return chars[index]
end

local spaces = function()
    return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
end

lualine.setup({
    options = {
        icons_enabled = true,
        theme = "gruvbox",
        component_separators = { left = "|", right = "" },
        section_separators = { left = "", right = "" },
        -- component_separators = { left = '', right = ''},
        -- section_separators = { left = '', right = ''},
        disabled_filetypes = { "alpha", "dashboard", "NvimTree", "Outline" },
        always_divide_middle = true,
    },
    sections = {
        lualine_a = { "mode" },
        lualine_b = { branch, diff, diagnostics },
        lualine_c = { "filename" },
        -- lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_x = { treesitter, lsp },
        lualine_y = { filetype, python_env },
        lualine_z = { "location" },
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
    },
    tabline = {},
    extensions = {},
})
