return function(dap)
    local function get_python_path()
        local venv = os.getenv("VIRTUAL_ENV")
        if venv == nil then return "/usr/bin/python" end
        local python_path = venv .. "/bin/python"
        if vim.fn.executable(python_path) == 1 then
            return python_path
        else
            return "/usr/bin/python"
        end
    end

    dap.adapters.python = {
        type = "executable",
        command = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python",
        args = { "-m", "debugpy.adapter" },
    }
    dap.configurations.python = {
        {
            name = "debug this file",
            type = "python",
            request = "launch",
            program = "${file}",
            console = "integratedTerminal",
            pythonPath = get_python_path,
        },
        {
            name = "debug these tests",
            type = "python",
            request = "launch",
            module = "pytest",
            args = {
                "${file}",
            },
            console = "integratedTerminal",
            pythonPath = get_python_path,
        },
    }
end
