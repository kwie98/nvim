local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
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
            windows = true, -- default bindings on <c-w>
            nav = true, -- misc bindings to work with windows
            z = true, -- bindings for folds, spelling and others prefixed with z
            g = false, -- bindings for prefixed with g
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
    triggers = "auto", -- automatically setup triggers
    -- triggers = {"<leader>"} -- or specify a list manually
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
    nowait = true, -- use `nowait` when CReating keymaps
}

local mappings = {
    ["b"] = {
        "<CMD>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<CR>",
        "Buffers",
    },
    ["e"] = { "<CMD>NvimTreeToggle<CR>", "Explorer" },
    ["t"] = { "<CMD>ToggleTerm<CR>", "Terminal" },
    ["q"] = { "<CMD>q!<CR>", "Quit" },
    ["c"] = { "<CMD>Bdelete!<CR>", "Close Buffer" },
    -- ["h"] = { "<CMD>nohlsearch<CR>", "No Highlight" },
    ["f"] = {
        "<CMD>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<CR>",
        "Find files",
    },
    ["F"] = { "<CMD>Telescope live_grep theme=ivy<CR>", "Find Text" },
    ["r"] = { "<CMD>lua require('telescope').extensions.projects.projects()<CR>", "Projects" },

    -- harpoon
    ["u"] = "which_key_ignore",
    ["i"] = "which_key_ignore",
    ["o"] = "which_key_ignore",
    ["p"] = "which_key_ignore",
    ["a"] = { "<CMD>lua require('harpoon.mark').add_file()<CR>", "Add to Harpoon" },
    ["h"] = { "<CMD>lua require('harpoon.ui').toggle_quick_menu()<CR>", "Harpoon" },

    -- quickfix
    ["j"] = "which_key_ignore",
    ["k"] = "which_key_ignore",

    P = {
        name = "Packer",
        c = { "<CMD>PackerCompile<CR>", "Compile" },
        i = { "<CMD>PackerInstall<CR>", "Install" },
        s = { "<CMD>PackerSync<CR>", "Sync" },
        S = { "<CMD>PackerStatus<CR>", "Status" },
        u = { "<CMD>PackerUpdate<CR>", "Update" },
    },

    g = {
        name = "Git",
        g = { "<CMD>lua _LAZYGIT_TOGGLE()<CR>", "Lazygit" },
        j = { "<CMD>lua require 'gitsigns'.next_hunk()<CR>", "Next Hunk" },
        k = { "<CMD>lua require 'gitsigns'.prev_hunk()<CR>", "Prev Hunk" },
        l = { "<CMD>lua require 'gitsigns'.blame_line()<CR>", "Blame" },
        p = { "<CMD>lua require 'gitsigns'.preview_hunk()<CR>", "Preview Hunk" },
        r = { "<CMD>lua require 'gitsigns'.reset_hunk()<CR>", "Reset Hunk" },
        R = { "<CMD>lua require 'gitsigns'.reset_buffer()<CR>", "Reset Buffer" },
        s = { "<CMD>lua require 'gitsigns'.stage_hunk()<CR>", "Stage Hunk" },
        u = {
            "<CMD>lua require 'gitsigns'.undo_stage_hunk()<CR>",
            "Undo Stage Hunk",
        },
        o = { "<CMD>Telescope git_status<CR>", "Open changed file" },
        b = { "<CMD>Telescope git_branches<CR>", "Checkout branch" },
        c = { "<CMD>Telescope git_commits<CR>", "Checkout commit" },
        d = {
            "<CMD>Gitsigns diffthis HEAD<CR>",
            "Diff",
        },
    },

    d = {
        name = "Debug",
        t = { "<CMD>lua require'dap'.toggle_breakpoint()<CR>", "Breakpoint" },
        l = { "<CMD>lua require'dap'.run_to_cursor()<CR>", "Run To Cursor" },
        i = { "<CMD>lua require'dap'.step_into()<CR>", "Step Into" },
        j = { "<CMD>lua require'dap'.step_over()<CR>", "Step Over" },
        o = { "<CMD>lua require'dap'.step_out()<CR>", "Step Out" },
        T = {
            "<CMD>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
            "Conditional Breakpoint",
        },
        L = { "<CMD>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>", "Logpoint" },
        b = { "<CMD>lua require'telescope'.extensions.dap.list_breakpoints()<CR>", "List Breakpoints" },
        v = { "<CMD>lua require'telescope'.extensions.dap.variables()<CR>", "List Variables" },
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

    l = {
        name = "LSP",
        a = { "<CMD>lua vim.lsp.buf.code_action()<CR>", "Code Action" },
        d = {
            "<CMD>Telescope lsp_document_diagnostics<CR>",
            "Document Diagnostics",
        },
        w = {
            "<CMD>Telescope lsp_workspace_diagnostics<CR>",
            "Workspace Diagnostics",
        },
        f = { "<CMD>lua vim.lsp.buf.formatting_sync()<CR>", "Format" },
        i = { "<CMD>LspInfo<CR>", "Info" },
        I = { "<CMD>LspInstallInfo<CR>", "Installer Info" },
        j = {
            "<CMD>lua vim.diagnostic.goto_next()<CR>",
            "Next Diagnostic",
        },
        k = {
            "<CMD>lua vim.diagnostic.goto_prev()<CR>",
            "Prev Diagnostic",
        },
        l = { "<CMD>lua vim.lsp.codelens.run()<CR>", "CodeLens Action" },
        q = { "<CMD>lua vim.diagnostic.set_loclist()<CR>", "Quickfix" },
        r = { "<CMD>lua vim.lsp.buf.rename()<CR>", "Rename" },
        s = { "<CMD>Telescope lsp_document_symbols<CR>", "Document Symbols" },
        S = {
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

which_key.setup(setup)
which_key.register(mappings, opts)
