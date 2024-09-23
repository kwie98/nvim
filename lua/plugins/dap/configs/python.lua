return function(dap)
    dap.adapters.python = {
        type = "executable",
        command = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python",
        args = { "-m", "debugpy.adapter" },
    }
    dap.configurations.python = {
        {
            name = "file",
            type = "python",
            request = "launch",
            cwd = "${workspaceFolder}",
            program = "${file}",
            console = "integratedTerminal",
            python = "python",
            justMyCode = false,
        },
        {
            name = "pytest",
            type = "python",
            request = "launch",
            cwd = "${workspaceFolder}",
            module = "pytest",
            args = { "${file}" },
            console = "integratedTerminal",
            python = "python",
            justMyCode = false,
        },
        {
            name = "fastapi",
            type = "python",
            request = "launch",
            cwd = "${workspaceFolder}",
            python = "python",
            program = "${env:VIRTUAL_ENV}/bin/fastapi",
            args = { "run", "backend/main.py" },
        },
    }
end
