---@type LazySpec
return {
    "folke/snacks.nvim",
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
    },
}
