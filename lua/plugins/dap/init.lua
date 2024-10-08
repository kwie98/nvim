return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "nvim-neotest/nvim-nio",
        -- "nvim-telescope/telescope-dap.nvim",
        "nvim-telescope/telescope.nvim",
        "rcarriga/cmp-dap",
        -- "mxsdev/nvim-dap-vscode-js",
        -- {
        --     "microsoft/vscode-js-debug",
        --     version = "1.x",
        --     build = "npm i && npm run compile vsDebugServerBundle && mv dist out",
        -- },
    },
    lazy = true,
    module = false, -- don't load dap even if required (e.g., by rust-tools.nvim)
    keys = {
        { "<F5>", mode = "n" },
        { "<F6>", mode = "n" },
        { "<F7>", mode = "n" },
        { "<F8>", mode = "n" },
        { "<Leader>dh", mode = "n", desc = "Toggle UI" },
        { "<Leader>dt", mode = "n", desc = "Breakpoint" },
        { "<Leader>dT", mode = "n", desc = "Conditional Breakpoint" },
    },
    enabled = vim.fn.has("win32") == 0,

    config = function()
        local dap = require("dap")
        local dapui = require("dapui")
        local cmp = require("cmp")

        -- Set up bindings that are only active while debugging, and whose original binds can be restored:
        -- WARNING: This probably only works with original binds with non-function rhs?
        -- Also set up automatic opening and closing of debugging UI.
        local override_binds = {
            { override = { "n", "<M-k>", dapui.eval } },
            { override = { "v", "<M-k>", dapui.eval } },
            { override = { "n", "<M-h>", dap.step_out } },
            { override = { "n", "<M-j>", dap.step_over } },
            { override = { "n", "<M-l>", dap.step_into } },
            { override = { "n", "<M-g>", dap.run_to_cursor } },
        }
        ---@param close boolean
        local function after_stop_debugging(close)
            -- WARNING: Is sometimes called twice
            print("stop debugging")
            if close then dapui.close() end
            for _, binds in pairs(override_binds) do
                local original_rhs = vim.fn.maparg(binds.override[2], binds.override[1])
                if binds.original_rhs ~= nil then
                    vim.keymap.set(binds.override[1], binds.override[2], binds.original_rhs)
                elseif original_rhs ~= "" then
                    vim.keymap.del(binds.override[1], binds.override[2])
                end
            end
        end
        local function after_start_debugging()
            print("start debugging")
            dapui.open({ reset = true })
            for _, binds in pairs(override_binds) do
                local original_rhs = vim.fn.maparg(binds.override[2], binds.override[1])
                if original_rhs ~= "" then binds.original_rhs = original_rhs end
                vim.keymap.set(unpack(binds.override))
            end
        end
        dap.listeners.after.event_initialized["dapui_config"] = function() after_start_debugging() end
        dap.listeners.before.event_terminated["dapui_config"] = function() after_stop_debugging(false) end
        dap.listeners.before.event_exited["dapui_config"] = function() after_stop_debugging(false) end

        -- Set up keys that are always available:
        vim.keymap.set("n", "<F5>", dap.continue)
        vim.keymap.set("n", "<F6>", function()
            dap.close()
            after_stop_debugging(true)
        end)
        vim.keymap.set("n", "<F7>", dap.run_last)
        vim.keymap.set("n", "<F8>", dap.step_over)
        vim.keymap.set("n", "<Leader>dh", function() dapui.toggle({ reset = true }) end, { desc = "Toggle UI" })
        -- vim.keymap.set("n", "<Leader>dm", dap_py.test_method, { desc = "Debug Test" })
        vim.keymap.set("n", "<Leader>dt", dap.toggle_breakpoint, { desc = "Breakpoint" })
        vim.keymap.set(
            "n",
            "<Leader>dT",
            function() dap.set_breakpoint(vim.fn.input("Breakpoint Condition: ")) end,
            { desc = "Conditional Breakpoint" }
        )
        -- vim.keymap.set("n", "<Leader>ds", telescope.extensions.dap.variables, { desc = "Variables" })
        -- vim.keymap.set("n", "<Leader>db", telescope.extensions.dap.list_breakpoints, { desc = "Breakpoints" })
        -- vim.keymap.set("n", "<Leader>df", telescope.extensions.dap.frames, { desc = "Frames" })

        cmp.setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
            sources = {
                { name = "dap" },
            },
        })

        vim.fn.sign_define("DapBreakpoint", {
            text = "⏺",
            texthl = "DiagnosticSignError",
            linehl = "",
            numhl = "",
        })

        require("plugins.dap.configs.python")(dap)
        -- require("plugins.dap.configs.typescript")(dap)

        -- Set up UI:
        -- telescope.load_extension("dap")
        dapui.setup({
            icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
            mappings = {
                expand = { "<Enter>", "<2-LeftMouse>" },
                open = "o",
                remove = "dd",
                edit = "cc",
                repl = "r",
                toggle = "t",
                -- add = { "a", "i", "o", "O" },
            },
            expand_lines = true,
            layouts = {
                {
                    elements = {
                        {
                            id = "scopes",
                            size = 2 / 5,
                        },
                        {
                            id = "watches",
                            size = 2 / 5,
                        },
                        {
                            id = "stacks",
                            size = 1 / 5,
                        },
                    },
                    size = 1 - 0.618,
                    position = "left",
                },
                {
                    elements = {
                        {
                            id = "repl",
                            size = 2 / 3,
                        },
                        {
                            id = "console",
                            size = 1 / 3,
                        },
                    },
                    size = 1 - 0.618,
                    position = "bottom",
                },
            },
            controls = { enabled = false },
            floating = {
                max_height = 0.85, -- These can be integers or a float between 0 and 1.
                max_width = 0.85, -- Floats will be treated as percentage of your screen.
                border = "single", -- Border style. Can be "single", "double" or "rounded"
                mappings = {
                    close = { "q", "<Esc>" },
                },
            },
            windows = { indent = 2 },
            render = { max_type_length = nil, max_value_lines = 20 },
        })
    end,
}
