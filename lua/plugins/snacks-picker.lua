local function test_picker()
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

        confirm = function(picker, item)
            picker:close()
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
            -- your picker configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        },
    },
    keys = {
        { "<Leader>b", function() Snacks.picker.buffers({ current = false }) end, desc = "Search Buffers" },
        { "<Leader>f", function() Snacks.picker.files() end, desc = "Search Files" },
        { "<Leader>t", function() Snacks.picker.grep() end, desc = "Live Grep" },
        { "<Leader>R", function() Snacks.picker.recent() end, desc = "Recent Files" },
        { "<F1>", function() Snacks.picker.help() end, desc = "Help" },
        -- { "<Leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
        { "<C-S-p>", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
        { "gd", function() Snacks.picker.lsp_definitions() end, desc = "Definions" },
        { "grr", function() Snacks.picker.lsp_references() end, desc = "References" },
        { "grm", function() Snacks.picker.lsp_implementations() end, desc = "Implementations" },
        { "grt", function() Snacks.picker.lsp_type_definitions() end, desc = "Type Definitions" },
        { "grd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
        { "<Leader>s", function() Snacks.picker.lsp_workspace_symbols() end, desc = "Symbols" },
        -- { "<Leader>gt", foo, desc = "Git Grep" },
        -- { "grd", function() Snacks.picker.diagnostics_workspace() end, desc = "Workspace Diagnostics" },
        -- TODO symbols: global vars maybe???
        { "<Leader>h", test_picker, desc = "test picker" },
    },
}
