local function picker() return require("snacks").picker end
local function pick_commit()
    -- local function format(item) return { { item.text, "SnacksPickerLabel" } } end
    -- local items = {
    --     { idx = 1, score = 1, text = "foo text", name = "foo name", file = "init.lua" },
    --     { idx = 2, score = 2, text = "bar text", name = "bar name", file = "selene.toml" },
    -- }
    return require("snacks").picker({
        live = true,

        finder = function(_, ctx)
            if ctx.filter.search == "" then return {} end
            local result = vim.fn.system("git log --pretty=format:'%h' --name-only -S '" .. ctx.filter.search .. "'")
            result = vim.trim(result) -- get rid of trailing newline
            if result == "" then return {} end

            ---@type snacks.picker.Item
            local items = {}
            for block in vim.gsplit(result, "\n\n") do
                local lines = vim.split(block, "\n")
                local commit = lines[1]
                local files = { unpack(lines, 2, #lines) }
                for _, file in ipairs(files) do
                    table.insert(items, { commit = commit, file = file })
                end
            end
            return items
        end,

        format = function(item) return { { item.file .. "\t" .. item.commit, "SnacksPickerLabel" } } end,
        preview = function(ctx)
            local lines = vim.fn.system("git show " .. ctx.item.commit .. ":" .. ctx.item.file)
            ctx.preview:set_lines(vim.split(lines, "\n"))
            local ft = vim.filetype.match({ filename = ctx.item.file })
            if ft then ctx.preview:highlight({ ft = ft }) end
        end,

        confirm = function(p, item)
            p:close()
            -- show commit in which the search string was found in the diff, and select the file with the change:
            require("diffview").open({
                item.commit .. "~1.." .. item.commit,
                "--selected-file=" .. item.file,
            })
        end,
    })
end
---@type LazySpec
return {
    "folke/snacks.nvim",
    ---@type snacks.Config
    opts = {
        picker = {
            main = {
                file = false, -- open in current window, even if oil or :term is there
            },
            win = {
                input = {
                    keys = {
                        ["<Esc>"] = { "close", mode = { "n", "i" } },
                    },
                },
            },
        },
    },
    keys = {
        { "<Leader>b", function() picker().buffers({ current = false }) end, desc = "Search Buffers" },
        { "<Leader>f", function() picker().files({ hidden = true }) end, desc = "Search Files" },
        { "<Leader>t", function() picker().grep({ hidden = true }) end, desc = "Live Grep" },
        -- { "<Leader>R", function() picker().recent() end, desc = "Recent Files" },
        { "<Leader>r", function() picker().recent({ filter = { cwd = true } }) end, desc = "Recent Files" },
        { "<F1>", function() picker().help() end, desc = "Help" },
        -- { "<Leader>gs", function() picker().git_status() end, desc = "Git Status" },
        { "<C-S-p>", function() picker().keymaps() end, desc = "Keymaps" },
        { "gd", function() picker().lsp_definitions() end, desc = "Definions" },
        { "grr", function() picker().lsp_references() end, desc = "References" },
        { "grm", function() picker().lsp_implementations() end, desc = "Implementations" },
        { "grt", function() picker().lsp_type_definitions() end, desc = "Type Definitions" },
        { "grd", function() picker().diagnostics() end, desc = "Diagnostics" },
        { "<Leader>s", function() picker().lsp_workspace_symbols() end, desc = "Symbols" },
        -- { "<Leader>gt", foo, desc = "Git Grep" },
        -- { "grd", function() picker().diagnostics_workspace() end, desc = "Workspace Diagnostics" },
        -- TODO symbols: global vars maybe???
        { "<Leader>h", pick_commit, desc = "Search commits" },
    },
}
