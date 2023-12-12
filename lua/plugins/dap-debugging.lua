return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "rcarriga/nvim-dap-ui",
        -- "nvim-telescope/telescope-dap.nvim",
        "nvim-telescope/telescope.nvim",
        "rcarriga/cmp-dap",
        "mfussenegger/nvim-dap-python",
    },
    lazy = true,
    module = false, -- don't load dap even if required (e.g., by rust-tools.nvim)
    keys = {
        { "<F5>", mode = "n" },
        { "<F6>", mode = "n" },
        { "<F7>", mode = "n" },
        { "<F8>", mode = "n" },
        { "<Leader>dh", mode = "n", desc = "Toggle UI" },
        -- { "<Leader>dm", mode = "n", desc = "Debug Test" },
        { "<Leader>dt", mode = "n", desc = "Breakpoint" },
        { "<Leader>dT", mode = "n", desc = "Conditional Breakpoint" },
        -- { "<Leader>ds", mode = "n", desc = "Variables" },
        -- { "<Leader>db", mode = "n", desc = "Breakpoints" },
        -- { "<Leader>df", mode = "n", desc = "Frames" },
    },
    enabled = vim.fn.has("win32") == 0,

    config = function()
        local dap = require("dap")
        local dap_launchjson = require("dap.ext.vscode")
        local dapui = require("dapui")
        -- local telescope = require("telescope")
        local cmp = require("cmp")
        local dap_py = require("dap-python")

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
            dapui.open()
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
        vim.keymap.set("n", "<F5>", function()
            dap_launchjson.load_launchjs()
            dap.continue({})
        end)
        vim.keymap.set("n", "<F6>", function()
            dap.close()
            after_stop_debugging(true)
        end)
        vim.keymap.set("n", "<F7>", dap.run_last)
        vim.keymap.set("n", "<F8>", dap.step_over)
        vim.keymap.set("n", "<Leader>dh", dapui.toggle, { desc = "Toggle UI" })
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
            texthl = "Error",
            linehl = "",
            numhl = "",
        })

        -- Set up debuggers:
        dap_py.setup(vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python")
        if not dap.adapters["pwa-node"] then
            require("dap").adapters["pwa-node"] = {
                type = "server",
                host = "localhost",
                port = "${port}",
                executable = {
                    command = "node",
                    args = {
                        require("mason-registry").get_package("js-debug-adapter"):get_install_path()
                            .. "/js-debug/src/dapDebugServer.js",
                        "${port}",
                    },
                },
            }
        end
        for _, language in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact" }) do
            if not dap.configurations[language] then
                dap.configurations[language] = {
                    {
                        type = "pwa-node",
                        request = "launch",
                        name = "Launch file",
                        program = "${file}",
                        cwd = "${workspaceFolder}",
                    },
                    {
                        type = "pwa-node",
                        request = "attach",
                        name = "Attach",
                        processId = require("dap.utils").pick_process,
                        cwd = "${workspaceFolder}",
                    },
                }
            end
        end

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
            },
            expand_lines = true,
            layouts = {
                {
                    elements = { "repl", "console" },
                    size = 0.25,
                    position = "bottom",
                },
                {
                    elements = { { id = "scopes", size = 0.5 }, { id = "watches", size = 0.5 } },
                    size = 0.25,
                    position = "left",
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
