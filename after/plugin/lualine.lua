local lualine = require("lualine")

local hide_in_width = function()
    return vim.fn.winwidth(0) > 60
end

-- local c = require("gruvbox-baby.colors").config()
-- c.bright_gray = "#928374"
-- c.other_gray = "#4F4743"
-- c.bright_orange = "#fe8019"

-- local theme = {
--     normal = {
--         a = { bg = c.bright_gray, fg = c.dark, gui = "bold" },
--         b = { bg = c.background, fg = c.milk },
--         c = { bg = c.background, fg = c.foreground },
--     },
--     insert = {
--         a = { bg = c.dark_gray, fg = c.dark, gui = "bold" },
--         b = { bg = c.background, fg = c.milk },
--         c = { bg = c.background, fg = c.milk },
--     },
--     visual = {
--         a = { bg = c.bright_orange, fg = c.dark, gui = "bold" },
--         b = { bg = c.medium_gray, fg = c.milk },
--         c = { bg = c.medium_gray, fg = c.milk },
--     },
--     replace = {
--         a = { bg = c.error_red, fg = c.dark, gui = "bold" },
--         b = { bg = c.background, fg = c.milk },
--         c = { bg = c.background, fg = c.milk },
--     },
--     command = {
--         a = { bg = c.magenta, fg = c.dark, gui = "bold" },
--         b = { bg = c.background, fg = c.milk },
--         c = { bg = c.background, fg = c.milk },
--     },
--     -- inactive = {
--     --     a = { bg = c.dark_gray, fg = c.gray, gui = "bold" },
--     --     b = { bg = c.dark_gray, fg = c.gray },
--     --     c = { bg = c.dark_gray, fg = c.gray },
--     -- },
-- }

local treesitter = {
    function()
        -- return ""
        local buf = vim.api.nvim_get_current_buf()
        local ts = vim.treesitter.highlighter.active[buf]
        if ts and not vim.tbl_isempty(ts) then
            return ""
        else
            return ""
        end
    end,
    -- color = { fg = c.clean_green, bg = c.medium_gray },
    -- color = function()
    --     local buf = vim.api.nvim_get_current_buf()
    --     local ts = vim.treesitter.highlighter.active[buf]
    --     return {
    --         fg = ts and not vim.tbl_isempty(ts) and "#8EA64C" or nil,
    --         bg = c.medium_gray,
    --     }
    -- end,
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
        -- local buf_ft = vim.bo.filetype
        local buf_client_names = {}

        -- add client
        for _, client in pairs(buf_clients) do
            if client.name ~= "null-ls" then
                table.insert(buf_client_names, client.name)
            end
        end

        -- if #buf_client_names == 0 then
        if #buf_client_names == 0 then
            return ""
        end

        -- -- add formatter
        -- local formatters = require("null-ls.utils.formatters")
        -- local supported_formatters = formatters.list_registered(buf_ft)
        -- vim.list_extend(buf_client_names, supported_formatters)

        -- -- add linter
        -- local linters = require("lvim.lsp.null-ls.linters")
        -- local supported_linters = linters.list_registered(buf_ft)
        -- vim.list_extend(buf_client_names, supported_linters)

        local unique_client_names = vim.fn.uniq(buf_client_names)
        return table.concat(unique_client_names, ", ")
    end,
    -- color = { fg = c.milk, bg = c.medium_gray },
    cond = hide_in_width,
    padding = { left = 0, right = 1 },
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
        theme = "auto",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        -- component_separators = { left = '', right = ''},
        -- section_separators = { left = '', right = ''},
        -- disabled_filetypes = { "alpha", "dashboard", "NvimTree", "Outline" },
        always_divide_middle = true,
        refresh = {
            statuslines = 1000,
            winbar = 1000,
        },
    },
    sections = {
        lualine_a = { "mode" },
        lualine_b = {
            {
                "filename",
                path = 1,
                symbols = {
                    modified = vim.g.modified_icon,
                    readonly = "[READONLY]",
                },
            },
            -- {
            --     "diagnostics",
            --     sources = { "nvim_diagnostic" },
            --     sections = { "error", "warn" },
            --     symbols = { error = " ", warn = " " },
            --     colored = false,
            --     update_in_insert = false,
            --     always_visible = true,
            --     colors = { fg = c.milk, bg = c.background },
            -- },
            {
                "branch",
                -- color = { fg = c.milk, bg = c.other_gray }, -- other_gray not working here idk
                icon = "",
            },
            {
                "diff",
                -- diff_color = {
                --     added = "GitGutterAdd",
                --     modified = "GitSignsChange",
                -- },
                colored = false,
                -- color = { fg = c.milk, bg = c.other_gray },
                padding = { left = 0, right = 1 },
                cond = hide_in_width,
            },
        },
        lualine_c = {},
        lualine_x = { treesitter, lsp },
        lualine_y = {
            {
                "filetype",
                icons_enabled = true,
                -- color = { fg = c.milk, bg = c.background },
            },
            {
                function()
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
                padding = { left = 0, right = 1 },
                cond = hide_in_width,
                -- color = { fg = c.milk, bg = c.background },
            },
        },
        lualine_z = { "progress" },
    },
    -- winbar = {
    --     lualine_c = { "filename" },
    -- },
    -- inactive_winbar = {
    --     lualine_c = { "filename" },
    -- },
    tabline = {},
    extensions = {"fugitive", "man", "nvim-dap-ui", "nvim-tree", "quickfix", "toggleterm"},
})
