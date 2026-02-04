return {
    name = "run script interactively",
    builder = function()
        local file = vim.fn.expand("%:p")
        local cmd
        if vim.bo.filetype == "python" then
            cmd = { "uv", "run", "python", "-i", file }
        else
            assert(false, "Filetype not supported: " .. vim.bo.filetype)
        end
        return {
            cmd = cmd,
            -- add some components that will pipe the output to quickfix,
            -- parse it using errorformat, and display any matching lines as diagnostics.
            components = {
                { "on_output_quickfix", set_diagnostics = true },
                "on_result_diagnostics",
                "default",
            },
        }
    end,
    condition = {
        -- filetype = { "sh", "python", "go" },
        filetype = { "python" },
    },
}
