U.load({ "nvim-treesitter.configs", "treesitter-context", "tsht" }, function(configs, context, tsht)

    -- nvim-treehopper
    -- vim.keymap.set("o", "m", tsht.nodes, {noremap = true, silent = true, desc = "Treehopper"})
    -- vim.keymap.set("x", "m", tsht.nodes, {noremap = true, silent = true, desc = "Treehopper"})
    vim.cmd([[
        omap     <silent> m :<C-U>lua require('tsht').nodes()<CR>
        xnoremap <silent> m :lua require('tsht').nodes()<CR>
    ]])

    configs.setup({
        playground = {
            enable = true
        },
        ensure_installed = "all", -- one of "all" or a list of languages
        --[[ ignore_install = { "markdown", "phpdoc" }, -- List of parsers to ignore installing ]]
        -- ignore_install = { "yaml" },
        highlight = {
            enable = true, -- false will disable the whole extension
            disable = { "css" }, -- list of language that will be disabled
        },
        autopairs = {
            enable = true,
        },
        indent = { enable = true, disable = { "css", "python", "yaml" } },
        incremental_selection = {
            enable = true,
            keymaps = {
                -- init_selection = "gnn",
                -- node_incremental = ",",
                -- scope_incremental = "grc",
                -- node_decremental = "–",
            },
        },
        matchup = {
            enable = true,
            disable_virtual_text = true,
        },
        textobjects = {
            select = {
                enable = true,
                lookahead = true,
                keymaps = {
                    -- ["ab"] = "@block.outer", -- meh
                    -- ["ib"] = "@block.inner",
                    ["af"] = "@call.outer",
                    ["if"] = "@call.inner",
                    ["ac"] = "@comment.outer", -- only does one line
                    ["ic"] = "@comment.outer",
                    -- ["ai"] = "@conditional.outer", -- eh
                    -- ["ii"] = "@conditional.inner",
                    ["am"] = "@function.outer", -- actually goated
                    ["im"] = "@function.inner",
                    -- ["al"] = "@loop.outer", -- meh
                    -- ["il"] = "@loop.inner",
                    ["aa"] = "@parameter.outer",
                    ["ia"] = "@parameter.inner",
                    -- ["aS"] = "@statement.outer", -- meh
                    -- ["iS"] = "@statement.outer",
                },
            },
            move = {
                enable = true,
                goto_next_start = {
                    [",w"] = "@parameter.inner",
                    ["]a"] = "@parameter.inner",
                    ["]]"] = "@class.outer",
                    ["]m"] = "@function.outer",
                    ["]f"] = "@call.outer",
                    ["]c"] = "@comment.outer",
                },
                goto_next_end = {
                    [",e"] = "@parameter.inner",
                    ["]A"] = "@parameter.inner",
                    ["]M"] = "@function.outer",
                    ["]F"] = "@call.outer",
                    ["]C"] = "@comment.outer",
                },
                goto_previous_start = {
                    [",b"] = "@parameter.inner",
                    ["[a"] = "@parameter.inner",
                    ["[["] = "@class.outer",
                    ["[m"] = "@function.outer",
                    ["[f"] = "@call.outer",
                    ["[c"] = "@comment.outer",
                },
                goto_previous_end = {
                    [",s"] = "@parameter.inner",
                    ["[A"] = "@parameter.inner",
                    ["[M"] = "@function.outer",
                    ["[F"] = "@call.outer",
                    ["[C"] = "@comment.outer",
                },
            },
        },
    })
    context.setup()
end)
