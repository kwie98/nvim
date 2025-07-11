local function fzf() return require("fzf-lua") end
local function foo()
    require("fzf-lua").fzf_live("git rev-list --all | xargs git grep --line-number --column --color=always <query>", {
        fzf_opts = {
            ["--delimiter"] = ":",
            ["--preview-window"] = "nohidden,down,60%,border-top,+{3}+3/3,~3",
        },
        preview = "git show {1}:{2} | " .. "bat --style=default --color=always --file-name={2} --highlight-line={3}",
    })
end

---@type LazySpec
return {
    "ibhagwan/fzf-lua",
    cmd = "FzfLua",
    keys = {
        { "<Leader>b", function() fzf().buffers() end, desc = "Search Buffers" },
        { "<Leader>f", function() fzf().files() end, desc = "Search Files" },
        { "<Leader>t", function() fzf().live_grep_native() end, desc = "Live Grep" },
        { "<Leader>sr", function() fzf().oldfiles({ cwd = "%:p:h" }) end, desc = "Old Files" },
        { "<F1>", function() fzf().helptags() end, desc = "Help" },
        { "<Leader>gs", function() fzf().git_status() end, desc = "Git Status" },
        { "<Leader>sk", function() fzf().keymaps() end, desc = "Keymaps" },
        { "gd", function() fzf().lsp_definitions() end, desc = "Definions" },
        { "grr", function() fzf().lsp_references() end, desc = "References" },
        { "gra", function() fzf().lsp_code_actions() end, desc = "Code actions" },
        { "grm", function() fzf().lsp_implementations() end, desc = "Implementations" },
        { "<Leader>gt", foo, desc = "Git Grep" },
    },

    ---@type fzf-lua.Config
    opts = {
        keymap = {
            builtin = {
                true, -- inherit default binds
                ["<C-u>"] = "preview-half-page-up",
                ["<C-d>"] = "preview-half-page-down",
            },
        },
    },
}
