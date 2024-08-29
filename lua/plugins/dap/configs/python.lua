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
            program = "${file}",
            console = "integratedTerminal",
            python = "python", -- works with rye
            justMyCode = false,
        },
        {
            name = "pytest",
            type = "python",
            request = "launch",
            module = "pytest",
            args = { "${file}" },
            console = "integratedTerminal",
            python = "${env:VIRTUAL_ENV}/bin/python", -- TODO?
            justMyCode = false,
        },
        {
            name = "fastapi",
            type = "python",
            request = "launch",
            cwd = "${workspaceFolder}",
            python = "${env:VIRTUAL_ENV}/bin/python",
            program = "${env:VIRTUAL_ENV}/bin/fastapi",
            args = { "run", "backend/main.py" },
        },
    }
end
