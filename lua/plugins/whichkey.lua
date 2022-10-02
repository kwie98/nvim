local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
    print("Could not load which-key.")
    return
end

local setup = {
    plugins = {
        marks = true, -- shows a list of your marks on ' and `
        registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
        spelling = {
            enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
            suggestions = 20, -- how many suggestions should be shown in the list?
        },
        -- the presets plugin, adds help for a bunch of default keybindings in Neovim
        -- No actual key bindings are CReated
        presets = {
            operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
            motions = false, -- adds help for motions
            text_objects = false, -- help for text objects triggered after entering an operator
            windows = false, -- default bindings on <c-w>
            nav = false, -- misc bindings to work with windows
            z = false, -- bindings for folds, spelling and others prefixed with z
            g = true, -- bindings for prefixed with g
        },
    },
    -- add operators that will trigger motion and text object completion
    -- to enable all native operators, set the preset / operators plugin above
    -- operators = { gc = "Comments" },
    key_labels = {
        -- override the label used to display some keys. It doesn't effect WK in any other way.
        -- For example:
        -- ["<space>"] = "SPC",
        -- ["<CR>"] = "RET",
        -- ["<tab>"] = "TAB",
    },
    icons = {
        breadCRumb = "»", -- symbol used in the command line area that shows your active key combo
        separator = ":", -- symbol used between a key and it's label
        group = "+", -- symbol prepended to a group
    },
    popup_mappings = {
        sCRoll_down = "<c-d>", -- binding to sCRoll down inside the popup
        sCRoll_up = "<c-u>", -- binding to sCRoll up inside the popup
    },
    window = {
        border = "none", -- none, single, double, shadow
        position = "bottom", -- bottom, top
        margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
        padding = { 1, 1, 1, 1 }, -- extra window padding [top, right, bottom, left]
        winblend = 0,
    },
    layout = {
        height = { min = 4, max = 25 }, -- min and max height of the columns
        width = { min = 20, max = 50 }, -- min and max width of the columns
        spacing = 3, -- spacing between columns
        align = "left", -- align columns left, center or right
    },
    ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
    hidden = {
        "<silent>",
        "<CMD>",
        "<CMD>",
        "<CR>",
        "call",
        "lua",
        "^:",
        "^ ",
        "<Plug>",
        "require'nvim--treesitter.textobjects.select'.select_textobject",
        "<Cmd> require",
    }, -- hide mapping boilerplate
    show_help = true, -- show help message on the command line when the popup is visible
    triggers = "auto", -- automatically setup triggers TODO test
    -- triggers = { "<leader>", "g" }, -- or specify a list manually TODO include register triggers
    triggers_blacklist = {
        -- list of mode / prefixes that should never be hooked by WhichKey
        -- this is mostly relevant for key maps that start with a native binding
        -- most people should not need to change this
        i = { "j", "k" },
        v = { "j", "k" },
    },
}

local opts = {
    mode = "n", -- NORMAL mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when CReating keymaps
    noremap = true, -- use `noremap` when CReating keymaps
    nowait = false, -- TODO what does this do?
}

local mappings = {
    w = {
        i = { "<CMD>edit ~/Documents/wiki2/README.md<CR>", "Wiki Index" },
        w = { "<CMD>Telekasten goto_thisweek<CR>", "This Week" },
        d = { "<CMD>Telekasten goto_today<CR>", "Today" },
        n = { "<CMD>Telekasten new_note<CR>", "New Note" },
        p = { "<CMD>Telekasten panel<CR>", "Wiki Panel" },
    },
    b = {
        "<CMD>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<CR>",
        "Buffers",
    },
    e = { "<CMD>NvimTreeToggle<CR>", "Explorer" },
    -- ["<Enter>"] = { "<CMD>ToggleTerm<CR>", "Terminal" },
    c = { "<CMD>Bdelete!<CR>", "Close Buffer" },
    f = {
        "<CMD>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<CR>",
        "Find files",
    },
    F = { "<CMD>Telescope live_grep theme=ivy<CR>", "Find Text" },
    j = { "<CMD>lua require('telescope').extensions.projects.projects()<CR>", "Projects" },

    -- harpoon
    u = "which_key_ignore",
    i = "which_key_ignore",
    o = "which_key_ignore",
    p = "which_key_ignore",
    a = { "<CMD>lua require('harpoon.mark').add_file()<CR>", "Add to Harpoon" },
    h = { "<CMD>lua require('harpoon.ui').toggle_quick_menu()<CR>", "Harpoon" },

    -- quickfix
    -- j = "which_key_ignore",
    -- k = "which_key_ignore",

    P = {
        name = "Packer",
        -- c = { "<CMD>PackerCompile<CR>", "Compile" },
        -- i = { "<CMD>PackerInstall<CR>", "Install" },
        s = { "<CMD>PackerSync<CR>", "Sync" },
        -- u = { "<CMD>PackerUpdate<CR>", "Update" },
    },

    g = {
        name = "Git",
        g = { "<CMD>Git<CR>", "Git" },
        h = { "<CMD>Gitsigns toggle_linehl<CR> | <CMD>Gitsigns toggle_deleted<CR>", "View Hunks" },
        b = { "<CMD>Gitsigns toggle_current_line_blame<CR>", "Blame" },
        -- l = { "<CMD>lua require'gitsigns'.setqflist( " },
        l = { "<CMD>Gitsigns setqflist 'all' open=false<CR>", "Quickfix" },

        r = { "<CMD>Gitsigns reset_hunk<CR>", "Reset Hunk" },
        R = { "<CMD>Gitsigns reset_buffer<CR>", "Reset Buffer" },
        s = { "<CMD>Gitsigns stage_hunk<CR>", "Stage Hunk" },
        S = { "<CMD>Gitsigns stage_buffer<CR>", "Stage Buffer" },
        u = { "<CMD>Gitsigns undo_stage_hunk<CR>", "Undo Stage Hunk" },

        d = { "<CMD>Gdiffsplit | wincmd x<CR>", "Diff File" },
        D = { "<CMD>Git difftool -y HEAD | 2,$tabdo wincmd x | wincmd w | tabnext<CR>", "Diff All Files" },
        m = { "<CMD>Git mergetool -y | tabprevious<CR>", "Merge" },

        -- l = { "<CMD>lua require 'gitsigns'.blame_line()<CR>", "Blame" },
        -- p = { "<CMD>lua require 'gitsigns'.preview_hunk()<CR>", "Preview Hunk" },
        f = { "<CMD>Telescope git_status<CR>", "Open changed file" },
        -- b = { "<CMD>Telescope git_branches<CR>", "Checkout branch" },
        -- c = { "<CMD>Telescope git_commits<CR>", "Checkout commit" },
        -- d = { "<CMD>Gitsigns diffthis HEAD<CR>", "Diff" },
        -- d = { "<CMD>lua require('gitsigns').diffthis('HEAD'); vim.cmd('wincmd x')<CR>", "Diff" }, -- TODO
    },

    d = {
        name = "Debug",
        s = { "<CMD>Telescope dap variables<CR>", "List Variables" },
        c = { "<CMD>lua require'dap'.run_to_cursor()<CR>", "Run To Cursor" },
        i = { "<CMD>lua require'dap'.step_into()<CR>", "Step Into" },
        j = { "<CMD>lua require'dap'.step_over()<CR>", "Step Over" },
        o = { "<CMD>lua require'dap'.step_out()<CR>", "Step Out" },
        t = { "<CMD>lua require'dap'.toggle_breakpoint()<CR>", "Breakpoint" },
        T = {
            "<CMD>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
            "Conditional Breakpoint",
        },
        m = { "<CMD>lua require'dap-python'.test_method()<CR>", "Test Method" },
        l = { "<CMD>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>", "Logpoint" },
        b = { "<CMD>lua require'telescope'.extensions.dap.list_breakpoints()<CR>", "List Breakpoints" },
        -- v = { "<CMD>lua require'telescope'.extensions.dap.variables()<CR>", "List Variables" },
        f = { "<CMD>lua require'telescope'.extensions.dap.frames()<CR>", "List Frames" },
        u = { "<CMD>lua require'dapui'.toggle()<CR>", "Toggle UI" },
        -- b = { "<CMD>lua require'dap'.step_back()<CR>", "Step Back" },
        -- c = { "<CMD>lua require'dap'.continue()<CR>", "Continue" },
        -- d = { "<CMD>lua require'dap'.disconnect()<CR>", "Disconnect" },
        -- g = { "<CMD>lua require'dap'.session()<CR>", "Get Session" },
        -- p = { "<CMD>lua require'dap'.pause.toggle()<CR>", "Pause" },
        -- r = { "<CMD>lua require'dap'.repl.toggle()<CR>", "Toggle Repl" },
        -- s = { "<CMD>lua require'dap'.continue()<CR>", "Start" },
        -- q = { "<CMD>lua require'dap'.close()<CR>", "Quit" },
    },

    m = {
        name = "Plugin Info",
        m = { "<CMD>LspInstallInfo<CR>", "Mason" },
        n = { "<CMD>NullLsInfo<CR>", "Null-ls" },
        p = { "<CMD>PackerStatus<CR>", "Packer" },
    },

    l = {
        name = "LSP",
        a = { "<CMD>lua vim.lsp.buf.code_action()<CR>", "Code Action" },
        -- d = {
        --     "<CMD>Telescope lsp_document_diagnostics<CR>",
        --     "Document Diagnostics",
        -- },
        -- W = {
        --     "<CMD>Telescope lsp_workspace_diagnostics<CR>",
        --     "Workspace Diagnostics",
        -- },
        -- f = { "<CMD>lua vim.lsp.buf.formatting_sync()<CR>", "Format" },
        i = { "<CMD>LspInfo<CR>", "Info" },
        x = { "<CMD>lua vim.lsp.codelens.run()<CR>", "CodeLens Action" },
        l = { "<CMD>lua vim.diagnostic.setqflist({open=false})<CR>", "Quickfix" },
        r = { "<CMD>lua vim.lsp.buf.rename()<CR>", "Rename" },
        s = { "<CMD>Telescope lsp_document_symbols<CR>", "Document Symbols" },
        w = {
            "<CMD>Telescope lsp_dynamic_workspace_symbols<CR>",
            "Workspace Symbols",
        },
    },

    s = {
        name = "Search",
        b = { "<CMD>Telescope git_branches<CR>", "Checkout branch" },
        c = { "<CMD>Telescope colorscheme<CR>", "Colorscheme" },
        h = { "<CMD>Telescope help_tags<CR>", "Find Help" },
        M = { "<CMD>Telescope man_pages<CR>", "Man Pages" },
        r = { "<CMD>Telescope oldfiles<CR>", "Open Recent File" },
        R = { "<CMD>Telescope registers<CR>", "Registers" },
        k = { "<CMD>Telescope keymaps<CR>", "Keymaps" },
        C = { "<CMD>Telescope commands<CR>", "Commands" },
        a = { "<CMD>lua require'telescope.builtin'.find_files({cwd='~', hidden=true})<CR>", "Find All Files" },
    },

    -- t = {
    --     name = "Terminal",
    --     n = { "<CMD>lua _NODE_TOGGLE()<CR>", "Node" },
    --     u = { "<CMD>lua _NCDU_TOGGLE()<CR>", "NCDU" },
    --     t = { "<CMD>lua _HTOP_TOGGLE()<CR>", "Htop" },
    --     p = { "<CMD>lua _PYTHON_TOGGLE()<CR>", "Python" },
    --     f = { "<CMD>ToggleTerm direction=float<CR>", "Float" },
    --     h = { "<CMD>ToggleTerm size=10 direction=horizontal<CR>", "Horizontal" },
    --     v = { "<CMD>ToggleTerm size=80 direction=vertical<CR>", "Vertical" },
    -- },
}

local v_opts = {
    mode = "v", -- NORMAL mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when CReating keymaps
    noremap = true, -- use `noremap` when CReating keymaps
    nowait = true, -- use `nowait` when CReating keymaps
}

local v_mappings = {
    g = {
        name = "Git",
        s = { ":Gitsigns stage_hunk<CR>", "Stage Hunk" },
        r = { ":Gitsigns reset_hunk<CR>", "Reset Hunk" },
    },
}

which_key.setup(setup)
which_key.register(mappings, opts)
which_key.register(v_mappings, v_opts)
