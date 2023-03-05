return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "nvim-telescope/telescope-dap.nvim",
            "nvim-telescope/telescope.nvim",
            "mfussenegger/nvim-dap-python",
            "rcarriga/cmp-dap",
        },
        lazy = true,
        module = false, -- don't load dap even if required (e.g., by rust-tools.nvim)
        keys = {
            { "<F5>", mode = "n" },
            { "<Leader>dh", mode = "n", desc = "Toggle UI" },
            { "<Leader>dm", mode = "n", desc = "Debug Test" },
            { "<Leader>dt", mode = "n", desc = "Breakpoint" },
            { "<Leader>dT", mode = "n", desc = "Conditional Breakpoint" },
            { "<Leader>dl", mode = "n", desc = "Logpoint" },
        },

        config = function()
            local dap = require("dap")
            local dap_launchjson = require("dap.ext.vscode")
            local dap_python = require("dap-python")
            local dapui = require("dapui")
            local telescope = require("telescope")
            local cmp = require("cmp")
            -- TODO do rust-tools dap setup

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

            vim.keymap.set("n", "<F5>", function()
                dap_launchjson.load_launchjs()
                dap.continue({})
            end)
            vim.keymap.set("n", "<F6>", dap.close)
            vim.keymap.set("n", "<F7>", dap.run_last)
            vim.keymap.set("n", "<F8>", dap.step_over)
            vim.keymap.set("n", "<M-k>", dapui.eval)
            vim.keymap.set("v", "<M-k>", dapui.eval)
            vim.keymap.set("n", "<Leader>dh", dapui.toggle, { desc = "Toggle UI" })

            vim.keymap.set("n", "<Leader>ds", telescope.extensions.dap.variables, { desc = "Variables" })
            vim.keymap.set("n", "<Leader>db", telescope.extensions.dap.list_breakpoints, { desc = "Breakpoints" })
            vim.keymap.set("n", "<Leader>df", telescope.extensions.dap.frames, { desc = "Frames" })

            vim.keymap.set("n", "<Leader>dm", dap_python.test_method, { desc = "Debug Test" })

            vim.keymap.set("n", "<Leader>dc", dap.run_to_cursor, { desc = "Run To Cursor" })
            vim.keymap.set("n", "<Leader>di", dap.step_into, { desc = "Step Into" })
            vim.keymap.set("n", "<Leader>dj", dap.step_over, { desc = "Step Over" })
            vim.keymap.set("n", "<Leader>do", dap.step_out, { desc = "Step Out" })

            vim.keymap.set("n", "<Leader>dt", dap.toggle_breakpoint, { desc = "Breakpoint" })
            vim.keymap.set("n", "<Leader>dT", function()
                dap.set_breakpoint(vim.fn.input("Breakpoint Condition: "))
            end, { desc = "Conditional Breakpoint" })
            -- vim.keymap.set("n", "<Leader>dl", function()
            --     dap.set_breakpoint({ log_message = vim.fn.input("Logpoint Message: ") })
            -- end, { desc = "Logpoint" })

            -- dap_python.setup(vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python")
            dap_python.setup(vim.fn.stdpath("data") .. "/debugpy/bin/python")

            telescope.load_extension("dap")
            dapui.setup({
                icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
                mappings = {
                    -- Use a table to apply multiple mappings
                    expand = { "<CR>", "<2-LeftMouse>" },
                    open = "o",
                    remove = "dd",
                    edit = "cc",
                    repl = "r",
                    toggle = "t",
                },
                expand_lines = true,
                layouts = {
                    {
                        elements = {
                            "repl",
                            "console",
                        },
                        size = 0.25,
                        position = "bottom",
                    },
                    {
                        elements = {
                            { id = "scopes", size = 0.5 },
                            { id = "watches", size = 0.5 },
                            -- { id = "frames", size = 0.25 },
                        },
                        size = 0.25,
                        position = "left",
                    },
                },
                controls = {
                    enabled = false,
                },
                floating = {
                    max_height = 0.85, -- These can be integers or a float between 0 and 1.
                    max_width = 0.85, -- Floats will be treated as percentage of your screen.
                    border = "single", -- Border style. Can be "single", "double" or "rounded"
                    mappings = {
                        close = { "q", "<Esc>" },
                    },
                },
                windows = { indent = 2 },
                render = {
                    max_type_length = nil, -- Can be integer or nil.
                    max_value_lines = 20, -- Can be integer or nil.
                },
            })
        end,
    },
}
