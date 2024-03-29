return {
    "nvim-neotest/neotest",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-lua/plenary.nvim",
        "mfussenegger/nvim-dap",
        "nvim-neotest/neotest-python",
        "marilari88/neotest-vitest",
    },
    keys = {
        { "<Leader>rt", mode = "n", desc = "Test" },
        -- { "<Leader>rl", mode = "n", desc = "Last Test" },
        { "<Leader>rT", mode = "n", desc = "All Tests" },
        { "<Leader>rd", mode = "n", desc = "Debug Test" },
        -- { "<Leader>rs", mode = "n", desc = "Stop Test" },
        { "<Leader>T", mode = "n", desc = "Test Panel" },
        { "<Leader>rw", mode = "n", desc = "Watch" },
        { "<Leader>rW", mode = "n", desc = "Watch All" },
    },

    config = function()
        local neotest = require("neotest")
        local neotest_python = require("neotest-python")
        local neotest_vitest = require("neotest-vitest")

        local function match_file_extension(extension)
            local matcher = function(path) return path:match(".*%." .. extension .. "$") end
            return matcher
        end

        neotest.setup({
            diagnostic = { enabled = false },
            status = { signs = false },
            adapters = {
                neotest_python({
                    dap = { justMyCode = false },
                    is_test_file = match_file_extension("py"),
                    -- is_test_file = function(path)
                    --     return path:match(".*%.py$") -- look at all python files
                    -- end,
                }),
                -- neotest_vitest({
                --     is_test_file = match_file_extension("ts")
                -- }),
                neotest_vitest,
            },
            summary = {
                mappings = {
                    expand = "-",
                    output = "o",
                    short = "O",
                    jumpto = "gd",
                    stop = "s",
                    mark = "m",
                    clear_marked = "<BS>",
                    run = { "t", "<Enter>" },
                    run_marked = { "T", "<S-Enter>" },
                    debug = "d",
                    watch = "w",
                },
            },
        })

        vim.keymap.set("n", "<Leader>rt", neotest.run.run, { desc = "Test" })
        vim.keymap.set("n", "<Leader>rl", neotest.run.run_last, { desc = "Last Test" })
        vim.keymap.set("n", "<Leader>rT", function() neotest.run.run(vim.fn.expand("%")) end, { desc = "All Tests" })
        vim.keymap.set("n", "<Leader>rd", function() neotest.run.run({ strategy = "dap" }) end, { desc = "Debug Test" })
        vim.keymap.set("n", "<Leader>rs", neotest.run.stop, { desc = "Stop Test" })
        vim.keymap.set("n", "<Leader>T", neotest.summary.toggle, { desc = "Test Panel" })
        -- vim.keymap.set("n", "<Leader>ro", neotest.output.open, { desc = "Output" })
        vim.keymap.set("n", "<Leader>rw", neotest.watch.toggle, { desc = "Watch" })
        vim.keymap.set(
            "n",
            "<Leader>rW",
            function() neotest.watch.toggle(vim.fn.expand("%")) end,
            { desc = "Watch All" }
        )
    end,
}
