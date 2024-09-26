return {
    on_init = function(client)
        if client.workspace_folders then
            local path = client.workspace_folders[1].name
            if vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc") then return end
        end

        client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
            runtime = {
                version = "LuaJIT",
            },
            workspace = {
                checkThirdParty = false,
                library = vim.api.nvim_get_runtime_file("", true),
            },
        })
    end,
    settings = {
        Lua = {
            format = {
                enable = false,
            },
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = "LuaJIT",
                -- Set up your lua path
                -- path = runtime_path,
            },
            -- diagnostics = {
            --     -- Get the language server to recognize the `vim` global
            --     globals = { "vim" },
            -- },
            -- workspace = {
            --     -- Make the server aware of Neovim runtime files
            --     -- library = vim.api.nvim_get_runtime_file("", true),
            --     checkThirdParty = false,
            -- },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
}
