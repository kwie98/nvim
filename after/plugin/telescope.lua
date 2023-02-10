local telescope = require("telescope")
local pickers = require("telescope.pickers")
local p_window = require("telescope.pickers.window")
local conf = require("telescope.config").values
local state = require("telescope.state")
local utils = require("telescope.utils")
local builtin = require("telescope.builtin")
local actions = require("telescope.actions")
local my_pickers = require("util.pickers")

-- local pickers = require("plugins.telescope.pickers")

telescope.setup({
    defaults = {
        border = true,
        borderchars = {
            prompt = { "─", " ", " ", " ", "─", "─", " ", " " },
            results = { " " },
            preview = { " " },
        },
        dynamic_preview_title = true, -- trying this out
        prompt_prefix = " ",
        selection_caret = " ",
        path_display = { "truncate" },
        file_ignore_patterns = { "^.git/" },
        mappings = {
            i = {
                ["<C-v>"] = actions.select_vertical,
                ["<C-s>"] = actions.select_horizontal,

                ["<C-b>"] = actions.results_scrolling_up,
                ["<C-f>"] = actions.results_scrolling_down,

                ["<C-Space>"] = actions.cycle_previewers_next,

                ["<Esc>"] = actions.close,
            },
        },
    },
    pickers = {
        find_files = {
            -- find_command = { "fd", vim.fn.expand("<cword>") },
            hidden = true,
            -- no_ignore = true,
        },
        live_grep = {
            additional_args = function()
                return { "--hidden" }
            end,
        },
    },
    extensions = {
        fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case", -- or "ignore_case" or "respect_case"
        },
        conda = {
            anaconda_path = "/data/conda",
        },
    },
})
telescope.load_extension("fzf")
telescope.load_extension("dap")

vim.keymap.set("n", "<Leader>f", builtin.find_files, { desc = "Find File" })
vim.keymap.set("n", "<Leader>F", builtin.live_grep, { desc = "Find Text" })

vim.keymap.set("n", "<Leader>gb", builtin.git_branches, { desc = "Checkout Branch" })
vim.keymap.set("n", "<Leader>gc", my_pickers.my_bcommits, { desc = "Find Revision" })

local filter_f_symbols = { symbols = { "function", "method", "class" } }
local filter_c_symbols = { symbols = { "constant" } }

-- search functions/methods/classes:
-- vim.keymap.set("n", "<Leader>ldf", function()
--     builtin.lsp_document_symbols(filter_f_symbols)
-- end, { desc = "Document Functions" })
vim.keymap.set("n", "<Leader>lm", function()
    builtin.lsp_dynamic_workspace_symbols(filter_f_symbols)
end, { desc = "Workspace Methods" })

-- search constants:
-- vim.keymap.set("n", "<Leader>ldc", function()
--     builtin.lsp_document_symbols(filter_c_symbols)
-- end, { desc = "Document Constants" })
vim.keymap.set("n", "<Leader>lc", function()
    builtin.lsp_dynamic_workspace_symbols(filter_c_symbols)
end, { desc = "Workspace Constants" })

-- search all symbols:
vim.keymap.set("n", "<Leader>ls", builtin.lsp_document_symbols, { desc = "Document Symbols" })
vim.keymap.set("n", "<Leader>lw", builtin.lsp_dynamic_workspace_symbols, { desc = "Workspace Symbols" })

-- search diagnostics:
vim.keymap.set("n", "<Leader>ld", function()
    builtin.diagnostics({ bufnr = 0 })
end, { desc = "Document Diagnostics" })
vim.keymap.set("n", "<Leader>lD", builtin.diagnostics, { desc = "Workspace Diagnostics" })

vim.keymap.set("n", "<Leader>sh", builtin.help_tags, { desc = "Find Help" })
vim.keymap.set("n", "<Leader>sM", builtin.man_pages, { desc = "Man Pages" })
vim.keymap.set("n", "<Leader>sr", builtin.oldfiles, { desc = "Open Recent File" })
vim.keymap.set("n", "<Leader>sk", builtin.keymaps, { desc = "Keymaps" })
vim.keymap.set("n", "<Leader>sa", function()
    builtin.find_files({ cwd = "~", hidden = true })
end, { desc = "Find in Home" })

vim.keymap.set("n", "<Leader>t", builtin.resume, { desc = "Resume Search" })

-- vim.keymap.set("n", "]t", function()
--     opts = opts or {}
--     opts.cache_index = vim.F.if_nil(opts.cache_index, 1)

--     local cached_pickers = state.get_global_key("cached_pickers")
--     if cached_pickers == nil or vim.tbl_isempty(cached_pickers) then
--         utils.notify("builtin.resume", {
--             msg = "No cached picker(s).",
--             level = "INFO",
--         })
--         return
--     end
--     local picker = cached_pickers[opts.cache_index]
--     if picker == nil then
--         utils.notify("builtin.resume", {
--             msg = string.format("Index too large as there are only '%s' pickers cached", #cached_pickers),
--             level = "ERROR",
--         })
--         return
--     end
--     -- reset layout strategy and get_window_options if default as only one is valid
--     -- and otherwise unclear which was actually set
--     if picker.layout_strategy == conf.layout_strategy then
--         picker.layout_strategy = nil
--     end
--     if picker.get_window_options == p_window.get_window_options then
--         picker.get_window_options = nil
--     end
--     picker.cache_picker.index = opts.cache_index

--     -- avoid partial `opts.cache_picker` at picker creation
--     if opts.cache_picker ~= false then
--         picker.cache_picker = vim.tbl_extend("keep", opts.cache_picker or {}, picker.cache_picker)
--     else
--         picker.cache_picker.disabled = true
--     end
--     opts.cache_picker = nil
--     picker.previewer = picker.all_previewers
--     if picker.hidden_previewer then
--         picker.hidden_previewer = nil
--         opts.previewer = vim.F.if_nil(opts.previewer, false)
--     end

--     local p = pickers.new(opts, picker)
--     local popup_opts = p:get_window_options(vim.o.columns, 10)

--     local prompt_win, prompt_opts, prompt_border_win = p:_create_window("", popup_opts)
--     local prompt_bufnr = vim.api.nvim_win_get_buf(prompt_win)
--     actions.move_selection_next(prompt_bufnr)
-- end)
