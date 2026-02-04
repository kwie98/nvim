local function overseer() return require("overseer") end
local function is_buf_visible_current_tab(bufnr)
  for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    if vim.api.nvim_win_get_buf(win) == bufnr then
      return true
    end
  end
  return false
end
local function watch_run(interactively)
    local task_name
    if interactively then
        task_name = "run script interactively"
    else
        task_name = "run script"
    end
    overseer().run_task({ name = task_name, autostart = false }, function(task)
        if task then
            -- vim.print(task)
            task:add_component({
                "restart_on_save",
                delay = 1,
                paths = { vim.fn.expand("%:p") },
            })
            task:add_component({
                "unique",
                replace = true,
            })
            task:start()
            if not is_buf_visible_current_tab(task:get_bufnr()) then
                task:open_output("vertical")
            end
        else
            vim.notify("WatchRun not supported for filetype " .. vim.bo.filetype, vim.log.levels.ERROR)
        end
    end)
end
return {
    "stevearc/overseer.nvim",
    dependencies = {
        "folke/snacks.nvim",
    },
    keys = {
        { "<Leader>ow", function() watch_run(false) end, desc = "Watch Run" },
        { "<Leader>oW", function() watch_run(true) end, desc = "Watch Run (Interactive)" },
        { "<Leader>oa", "<CMD>OverseerTaskAction<CR>", desc = "Task Action" },
        { "<Leader>or", "<CMD>OverseerRun<CR>", desc = "Run Task" },
        { "<Leader>oo", "<CMD>OverseerToggle<CR>", desc = "Toggle View" },
        {
            "<Leader>od",
            function()
                local tasks = overseer().list_tasks()
                local names = {}
                for _, task in ipairs(tasks) do
                    task:dispose(true)
                    names[#names + 1] = task.name
                end
                vim.notify("disposed " .. #names .. " tasks: " .. table.concat(names, ", "))
            end,
            desc = "Dispose All Tasks",
        },
    },
    ---@module 'overseer'
    ---@type overseer.SetupOpts
    opts = {
        dap = false,
        output = {
            preserve_output = true,
        },
        task_list = {
            keymaps = {
                ["?"] = "keymap.show_help",
                ["g?"] = "keymap.show_help",
                ["<CR>"] = "keymap.run_action",
                ["dd"] = { "keymap.run_action", opts = { action = "dispose" }, desc = "Dispose task" },
                ["<C-e>"] = { "keymap.run_action", opts = { action = "edit" }, desc = "Edit task" },
                ["o"] = "keymap.open",
                ["<C-v>"] = { "keymap.open", opts = { dir = "vsplit" }, desc = "Open task output in vsplit" },
                ["<C-s>"] = { "keymap.open", opts = { dir = "split" }, desc = "Open task output in split" },
                ["<C-t>"] = { "keymap.open", opts = { dir = "tab" }, desc = "Open task output in tab" },
                ["<C-f>"] = { "keymap.open", opts = { dir = "float" }, desc = "Open task output in float" },
                ["<C-q>"] = {
                    "keymap.run_action",
                    opts = { action = "open output in quickfix" },
                    desc = "Open task output in the quickfix",
                },
                ["p"] = "keymap.toggle_preview",
                ["{"] = "keymap.prev_task",
                ["}"] = "keymap.next_task",
                ["<C-k>"] = false,
                ["<C-j>"] = false,
                ["g."] = "keymap.toggle_show_wrapped",
                ["q"] = { "<CMD>close<CR>", desc = "Close task list" },
            },
        },
    },
}
