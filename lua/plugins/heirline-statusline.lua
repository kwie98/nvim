return {
    "rebelot/heirline.nvim",
    dependencies = {
        "mfussenegger/nvim-lint",
    },
    lazy = false, -- Needed for winbar at start

    config = function()
        local heirline = require("heirline")
        local utils = require("heirline.utils")
        local conditions = require("heirline.conditions")

        -- Left:
        local cwd = {
            provider = function() return " " .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t") .. " " end,
            hl = "HeirlineCwd",
        }
        local relative_path = {
            flexible = 2,
            {
                provider = function()
                    local path = vim.fn.fnamemodify(vim.fn.expand("%"), ":.:h")
                    if path == "." then return " " end
                    return " " .. path .. "/"
                end,
                hl = "HeirlineSeparator",
            },
            {
                provider = function()
                    local path = vim.fn.fnamemodify(vim.fn.pathshorten(vim.fn.expand("%")), ":.:h")
                    if path == "." then return " " end
                    return " " .. path .. "/"
                end,
                hl = "HeirlineSeparator",
            },
        }
        local file_name = {
            provider = function()
                local name = vim.fn.expand("%:t")
                if name == "" then name = "[No Name]" end
                return name
            end,
            hl = "HeirlineFileName",
        }
        local file_status = {
            provider = function()
                local status = ""
                if vim.bo.readonly then status = status .. " 👀" end
                if vim.bo.modified then status = status .. " ●" end
                return status .. " "
            end,
            hl = "HeirlineFileStatus",
        }
        local git_branch = {
            -- Choose a StatusLine:
            fallthrough = false,
            -- Either, a branch indicator:
            {
                condition = conditions.is_git_repo,
                { provider = "", hl = "HeirlineGitLeft" },
                {
                    provider = function()
                        ---@diagnostic disable-next-line: undefined-field
                        local branch = vim.b.gitsigns_head
                        if branch ~= nil then return " " .. branch .. " " end
                        return ""
                    end,
                    hl = "HeirlineGitBranch",
                },
                { provider = "", hl = "HeirlineGitRight" },
            },
            -- Or, a simple divider:
            { provider = "", hl = "HeirlineSeparator" },
        }

        -- Right:
        local tools = {
            -- Chose a StatusLine:
            fallthrough = false,
            -- Either, a list of active tools:
            {
                condition = function(self)
                    self.clients = {}
                    for _, client in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
                        self.clients[#self.clients + 1] = client.name
                    end
                    self.linters = require("lint").linters_by_ft[vim.bo.filetype] or {}

                    if #self.clients > 0 or #self.linters > 0 then return true end
                    return false
                end,
                { provider = "", hl = "HeirlineEnd" },
                {
                    provider = function(self) return " " .. table.concat(self.clients, " ") .. " " end,
                    hl = "HeirlineLspClients",
                },
                {
                    flexible = 1,
                    {
                        provider = function(self)
                            if #self.linters > 0 then
                                return table.concat(self.linters, " ") .. " "
                            else
                                return ""
                            end
                        end,
                        hl = "HeirlineSeparator",
                    },
                    {
                        provider = function(self)
                            if #self.linters > 0 then
                                return "… "
                            else
                                return ""
                            end
                        end,
                        hl = "HeirlineSeparator",
                    },
                },
                { provider = "", hl = "HeirlineToolsError" },
            },
            -- Or, a divider:
            { provider = "", hl = "HeirlineNoneError" },
        }
        local get_diagnostic_count = function(str)
            local count = #vim.diagnostic.get(0, { severity = str })
            if count > 0 then return " " .. count .. " " end
            return ""
        end
        local ribbon = {
            {
                provider = function() return get_diagnostic_count(vim.diagnostic.severity.ERROR) end,
                hl = "HeirlineErrorCount",
            },
            { provider = "", hl = "HeirlineErrorWarn" },
            {
                provider = function() return get_diagnostic_count(vim.diagnostic.severity.WARN) end,
                hl = "HeirlineWarnCount",
            },
            { provider = "", hl = "HeirlineWarnInfo" },
            {
                provider = function() return get_diagnostic_count(vim.diagnostic.severity.INFO) end,
                hl = "HeirlineInfoCount",
            },
            { provider = "", hl = "HeirlineInfoHint" },
            {
                provider = function() return get_diagnostic_count(vim.diagnostic.severity.HINT) end,
                hl = "HeirlineHintCount",
            },
            { provider = "", hl = "HeirlineHintFiletype" },
        }
        local file_type = {
            provider = function() return " " .. vim.bo.filetype .. " " end,
            hl = "HeirlineFileType",
        }
        local tab_count = {
            { provider = " ", hl = "HeirlineSeparator" },
            {
                provider = function() return vim.fn.tabpagenr() .. "/" .. #vim.api.nvim_list_tabpages() end,
            },
            condition = function() return #vim.api.nvim_list_tabpages() >= 2 end,
            hl = "HeirlineFileType",
        }

        -- Needed for correct color updates on colorscheme change:
        local function get_colors() return {} end

        heirline.setup({
            opts = {
                colors = get_colors,
                disable_winbar_cb = function(args)
                    return conditions.buffer_matches({
                        buftype = { "nofile", "terminal", "quickfix" },
                        filetype = { "^git.*", "fugitive" },
                    }, args.buf)
                end,
            },
            statusline = {
                cwd,
                git_branch,
                relative_path,
                file_name,
                file_status,
                { provider = "", hl = "HeirlineEnd" },
                { provider = "%=", hl = "Heirline" }, -- aligns following to right
                tools,
                ribbon,
                file_type,
                tab_count,
            },
            winbar = {
                relative_path,
                file_name,
                file_status,
                { provider = "", hl = "HeirlineWinBarEnd" },
            },
        })

        vim.api.nvim_create_augroup("Heirline", { clear = true })
        vim.api.nvim_create_autocmd("ColorScheme", {
            callback = function() utils.on_colorscheme(get_colors) end,
            group = "Heirline",
        })
    end,
}
