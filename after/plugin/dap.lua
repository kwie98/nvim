require("dap")

-- dap
vim.fn.sign_define("DapBreakpoint", {
    text = "⏺",
    texthl = "LspDiagnosticsSignError",
    linehl = "",
    numhl = "",
})

local status_ok, dap_python = pcall(require, "dap-python")
if not status_ok then
    print("Could not load dap-python.")
    return
end

-- dap-python
-- local prefix = os.getenv("CONDA_PREFIX")
-- if prefix == nil then
--     prefix = "/usr"
-- end
-- local cmd = prefix .. "/bin/python"

dap_python.setup("~/.local/share/nvim/mason/packages/debugpy/venv/bin/python")


-- dap.adapters.python = {
--     type = "executable",
--     command = cmd,
--     args = { "-m", "debugpy.adapter" },
-- }
-- dap.configurations.python = {
--     {
--         -- The first three options are required by nvim-dap
--         type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
--         request = "launch",
--         name = "Launch file",
--         -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options
--         program = "${file}", -- This configuration will launch the current file if used.
--         -- pythonPath = function()
--         --     -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
--         --     -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
--         --     -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
--         --     local cwd = vim.fn.getcwd()
--         --     if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
--         --         return cwd .. '/venv/bin/python'
--         --     elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
--         --         return cwd .. '/.venv/bin/python'
--         --     else
--         --         return '/usr/bin/python'
--         --     end
--         -- end;
--     },
-- }

local status_ok, dapui = pcall(require, "dapui")
if not status_ok then
    print("Could not load dapui.")
    return
end

-- dapui
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
    -- Expand lines larger than the window
    -- Requires >= 0.7
    expand_lines = true,
    -- Layouts define sections of the screen to place windows.
    -- The position can be "left", "right", "top" or "bottom".
    -- The size specifies the height/width depending on position. It can be an Int
    -- or a Float. Integer specifies height/width directly (i.e. 20 lines/columns) while
    -- Float value specifies percentage (i.e. 0.3 - 30% of available lines/columns)
    -- Elements are the elements shown in the layout (in order).
    -- Layouts are opened in order so that earlier layouts take priority in window sizing.
    layouts = {
        {
            elements = {
                -- Elements can be strings or table with id and size keys.
                { id = "scopes", size = 0.35 },
                { id = "watches", size = 0.5 },
                -- "breakpoints",
                { id = "stacks", size = 0.15 },
            },
            size = 0.25, -- 25% of total columns
            position = "left",
        },
        {
            elements = {
                "repl",
                "console",
            },
            size = 0.25, -- 25% of total lines
            position = "bottom",
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
        max_value_lines = 10, -- Can be integer or nil.
    },
})
