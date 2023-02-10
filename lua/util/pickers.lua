local make_entry = require("telescope.make_entry")
local action_state = require("telescope.actions.state")
local utils = require("telescope.utils")
local finders = require("telescope.finders")
local previewers = require("telescope.previewers")
local actions = require("telescope.actions")
local pickers = require("telescope.pickers")
local conf = require("telescope.config").values
local Path = require("plenary.path")
local M = {}

local get_current_buf_line = function(winnr)
    local lnum = vim.api.nvim_win_get_cursor(winnr)[1]
    return vim.trim(vim.api.nvim_buf_get_lines(vim.api.nvim_win_get_buf(winnr), lnum - 1, lnum, false)[1])
end

-- normal bcommits picker, but with changed previewer order : ) : )
M.my_bcommits = function(opts)
    opts.bufnr = opts.bufnr or vim.api.nvim_get_current_buf()
    opts.winnr = opts.winnr or vim.api.nvim_get_current_win()
    opts.current_line = (opts.current_file == nil) and get_current_buf_line(opts.winnr) or nil
    opts.current_file = vim.F.if_nil(opts.current_file, vim.api.nvim_buf_get_name(opts.bufnr))
    opts.entry_maker = vim.F.if_nil(opts.entry_maker, make_entry.gen_from_git_commits(opts))
    local git_command =
        vim.F.if_nil(opts.git_command, { "git", "log", "--pretty=oneline", "--abbrev-commit", "--follow" })

    pickers
        .new(opts, {
            prompt_title = "Git BCommits",
            finder = finders.new_oneshot_job(
                vim.tbl_flatten({
                    git_command,
                    opts.current_file,
                }),
                opts
            ),
            previewer = {
                previewers.git_commit_diff_as_was.new(opts),
                previewers.git_commit_message.new(opts),
                previewers.git_commit_diff_to_parent.new(opts),
                previewers.git_commit_diff_to_head.new(opts),
            },
            sorter = conf.file_sorter(opts),
            attach_mappings = function()
                actions.select_default:replace(actions.git_checkout_current_buffer)
                local transfrom_file = function()
                    return opts.current_file and Path:new(opts.current_file):make_relative(opts.cwd) or ""
                end

                local get_buffer_of_orig = function(selection)
                    local value = selection.value .. ":" .. transfrom_file()
                    local content = utils.get_os_command_output({ "git", "--no-pager", "show", value }, opts.cwd)

                    local bufnr = vim.api.nvim_create_buf(false, true)
                    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, content)
                    vim.api.nvim_buf_set_name(bufnr, "Original")
                    return bufnr
                end

                local vimdiff = function(selection, command)
                    local ft = vim.bo.filetype
                    vim.cmd("diffthis")

                    local bufnr = get_buffer_of_orig(selection)
                    vim.cmd(string.format("%s %s", command, bufnr))
                    vim.bo.filetype = ft
                    vim.cmd("diffthis")

                    vim.api.nvim_create_autocmd("WinClosed", {
                        buffer = bufnr,
                        nested = true,
                        once = true,
                        callback = function()
                            vim.api.nvim_buf_delete(bufnr, { force = true })
                        end,
                    })
                end

                actions.select_default:replace(function(prompt_bufnr)
                    actions.close(prompt_bufnr)
                    local selection = action_state.get_selected_entry()
                    vimdiff(selection, "leftabove vert sbuffer")
                end)

                actions.select_vertical:replace(function(prompt_bufnr)
                    actions.close(prompt_bufnr)
                    local selection = action_state.get_selected_entry()
                    vimdiff(selection, "leftabove vert sbuffer")
                end)

                actions.select_horizontal:replace(function(prompt_bufnr)
                    actions.close(prompt_bufnr)
                    local selection = action_state.get_selected_entry()
                    vimdiff(selection, "belowright sbuffer")
                end)

                actions.select_tab:replace(function(prompt_bufnr)
                    actions.close(prompt_bufnr)
                    local selection = action_state.get_selected_entry()
                    vim.cmd("tabedit " .. transfrom_file())
                    vimdiff(selection, "leftabove vert sbuffer")
                end)
                return true
            end,
        })
        :find()
end

local set_opts_cwd = function(opts)
    if opts.cwd then
        opts.cwd = vim.fn.expand(opts.cwd)
    else
        opts.cwd = vim.loop.cwd()
    end

    -- Find root of git directory and remove trailing newline characters
    local git_root, ret = utils.get_os_command_output({ "git", "rev-parse", "--show-toplevel" }, opts.cwd)
    local use_git_root = vim.F.if_nil(opts.use_git_root, true)

    if ret ~= 0 then
        local in_worktree = utils.get_os_command_output({ "git", "rev-parse", "--is-inside-work-tree" }, opts.cwd)
        local in_bare = utils.get_os_command_output({ "git", "rev-parse", "--is-bare-repository" }, opts.cwd)

        if in_worktree[1] ~= "true" and in_bare[1] ~= "true" then
            error(opts.cwd .. " is not a git directory")
        elseif in_worktree[1] ~= "true" and in_bare[1] == "true" then
            opts.is_bare = true
        end
    else
        if use_git_root then
            opts.cwd = git_root[1]
        end
    end
end

local function apply_checks(mod)
    for k, v in pairs(mod) do
        mod[k] = function(opts)
            opts = vim.F.if_nil(opts, {})

            set_opts_cwd(opts)
            v(opts)
        end
    end

    return mod
end

return apply_checks(M)
