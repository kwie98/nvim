return function(dap)
    dap.adapters.python = {
        type = "executable",
        command = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python",
        args = { "-m", "debugpy.adapter" },
    }
    dap.configurations.python = {
        {
            type = "python",
            request = "launch",
            name = "Debug File",
            program = "${file}",
            console = "integratedTerminal",
            pythonPath = function()
                local venv = os.getenv("VIRTUAL_ENV")
                if venv == nil then
                    return "/usr/bin/python"
                end
                local python_path = venv .. "/bin/python"
                if vim.fn.executable(python_path) == 1 then
                    return python_path
                else
                    return "/usr/bin/python"
                end
            end,
        },
    }
end
