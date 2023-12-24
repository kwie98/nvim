return function(dap)
    require("dap-vscode-js").setup({
        -- node_path = "node",
        -- debugger_cmd = { "js-debug-adapter" },
        -- debugger_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug",
        debugger_path = vim.fn.stdpath("data") .. "/mason/bin/js-debug-adapter",
        debugger_cmd = { "js-debug-adapter" },
        adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
        port = "${port}",
    })

    local fts = {
        "javascript",
        "typescript",
        "javascriptreact",
        "typescriptreact",
        -- using pwa-chrome
        "vue",
        "svelte",
    }

    for _, ft in ipairs(fts) do
        dap.configurations[ft] = {
            {
                name = "Vitest Debug",
                type = "pwa-node",
                request = "launch",
                cwd = vim.fn.getcwd(),
                program = "${workspaceFolder}/node_modules/vitest/vitest.mjs",
                args = { "--threads", "false", "run", "${file}" },
                autoAttachChildProcesses = true,
                smartStep = true,
                console = "integratedTerminal",
                skipFiles = { "<node_internals>/**", "node_modules/**" },
                -- port = "${port}",
            },
            {
                type = "pwa-node",
                request = "launch",
                name = "Launch Test Program (pwa-node with vitest)",
                cwd = vim.fn.getcwd(),
                program = "${workspaceFolder}/node_modules/vitest/vitest.mjs",
                args = { "--inspect-brk", "--threads", "false", "run", "${file}" },
                autoAttachChildProcesses = true,
                smartStep = true,
                console = "integratedTerminal",
                skipFiles = { "<node_internals>/**", "node_modules/**" },
            },
        }
    end

    -- for _, language in ipairs(fts) do
    --     dap.configurations[language] = {
    --         {
    --             type = "pwa-node",
    --             request = "launch",
    --             name = "Launch file",
    --             program = "${file}",
    --             cwd = "${workspaceFolder}",
    --         },
    --         {
    --             type = "pwa-node",
    --             request = "attach",
    --             name = "Attach",
    --             processId = require("dap.utils").pick_process,
    --             cwd = "${workspaceFolder}",
    --         },
    --         {
    --             type = "pwa-chrome",
    --             request = "launch",
    --             name = 'Start Chrome with "localhost"',
    --             url = "http://localhost:3000",
    --             webRoot = "${workspaceFolder}",
    --             userDataDir = "${workspaceFolder}/.vscode/vscode-chrome-debug-userdatadir",
    --         },
    --     }
    -- end

    -- for _, ft in ipairs(fts) do
    --     dap.configurations[ft] = {
    --         -- attach to a node process that has been started with
    --         -- `--inspect` for longrunning tasks or `--inspect-brk` for short tasks
    --         -- npm script -> `node --inspect-brk ./node_modules/.bin/vite dev`
    --         {
    --             -- use nvim-dap-vscode-js's pwa-node debug adapter
    --             type = "pwa-node",
    --             -- attach to an already running node process with --inspect flag
    --             -- default port: 9222
    --             request = "attach",
    --             -- allows us to pick the process using a picker
    --             processId = require("dap.utils").pick_process,
    --             -- name of the debug action you have to select for this config
    --             name = "Attach debugger to existing `node --inspect` process",
    --             -- for compiled languages like TypeScript or Svelte.js
    --             sourceMaps = true,
    --             -- resolve source maps in nested locations while ignoring node_modules
    --             resolveSourceMapLocations = {
    --                 "${workspaceFolder}/**",
    --                 "!**/node_modules/**",
    --             },
    --             -- path to src in vite based projects (and most other projects as well)
    --             cwd = "${workspaceFolder}/src",
    --             -- we don't want to debug code inside node_modules, so skip it!
    --             skipFiles = { "${workspaceFolder}/node_modules/**/*.js" },
    --         },
    --         {
    --             type = "pwa-chrome",
    --             name = "Launch Chrome to debug client",
    --             request = "launch",
    --             url = "http://localhost:5173",
    --             sourceMaps = true,
    --             protocol = "inspector",
    --             port = 9222,
    --             webRoot = "${workspaceFolder}/src",
    --             -- skip files from vite's hmr
    --             skipFiles = { "**/node_modules/**/*", "**/@vite/*", "**/src/client/*", "**/src/*" },
    --         },
    --     }
    -- end

    -- for _, ft in ipairs(fts) do
    --     dap.configurations[ft] = {
    --         {
    --             type = "pwa-node",
    --             request = "launch",
    --             name = "Launch Current File (pwa-node)",
    --             cwd = vim.fn.getcwd(),
    --             args = { "${file}" },
    --             sourceMaps = true,
    --             protocol = "inspector",
    --         },
    --         {
    --             type = "pwa-node",
    --             request = "launch",
    --             name = "Launch Current File (pwa-node with ts-node)",
    --             cwd = vim.fn.getcwd(),
    --             runtimeArgs = { "--loader", "ts-node/esm" },
    --             runtimeExecutable = "node",
    --             args = { "${file}" },
    --             sourceMaps = true,
    --             protocol = "inspector",
    --             skipFiles = { "<node_internals>/**", "node_modules/**" },
    --             resolveSourceMapLocations = {
    --                 "${workspaceFolder}/**",
    --                 "!**/node_modules/**",
    --             },
    --         },
    --         {
    --             type = "pwa-node",
    --             request = "launch",
    --             name = "Launch Current File (pwa-node with deno)",
    --             cwd = vim.fn.getcwd(),
    --             runtimeArgs = { "run", "--inspect-brk", "--allow-all", "${file}" },
    --             runtimeExecutable = "deno",
    --             attachSimplePort = 9229,
    --         },
    --         {
    --             type = "pwa-node",
    --             request = "launch",
    --             name = "Launch Test Current File (pwa-node with jest)",
    --             cwd = vim.fn.getcwd(),
    --             runtimeArgs = { "${workspaceFolder}/node_modules/.bin/jest" },
    --             runtimeExecutable = "node",
    --             args = { "${file}", "--coverage", "false" },
    --             rootPath = "${workspaceFolder}",
    --             sourceMaps = true,
    --             console = "integratedTerminal",
    --             internalConsoleOptions = "neverOpen",
    --             skipFiles = { "<node_internals>/**", "node_modules/**" },
    --         },
    --         {
    --             type = "pwa-node",
    --             request = "launch",
    --             name = "Launch Test Current File (pwa-node with vitest)",
    --             cwd = vim.fn.getcwd(),
    --             program = "${workspaceFolder}/node_modules/vitest/vitest.mjs",
    --             args = {
    --                 "--inspect-brk",
    --                 "--poolOptions.threads.singleThread",
    --                 -- "--threads",
    --                 -- "false",
    --                 "run",
    --                 "${file}",
    --             },
    --             autoAttachChildProcesses = true,
    --             smartStep = true,
    --             console = "integratedTerminal",
    --             skipFiles = { "<node_internals>/**", "node_modules/**" },
    --         },
    --         {
    --             type = "pwa-node",
    --             request = "launch",
    --             name = "Launch Test Current File (pwa-node with deno)",
    --             cwd = vim.fn.getcwd(),
    --             runtimeArgs = { "test", "--inspect-brk", "--allow-all", "${file}" },
    --             runtimeExecutable = "deno",
    --             smartStep = true,
    --             console = "integratedTerminal",
    --             attachSimplePort = 9229,
    --         },
    --         {
    --             type = "pwa-chrome",
    --             request = "attach",
    --             name = "Attach Program (pwa-chrome, select port)",
    --             program = "${file}",
    --             cwd = vim.fn.getcwd(),
    --             sourceMaps = true,
    --             port = function() return vim.fn.input("Select port: ", 9222) end,
    --             webRoot = "${workspaceFolder}",
    --         },
    --     }
    -- end
end
