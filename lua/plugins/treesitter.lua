local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
    return
end

require("nvim-treesitter.parsers").filetype_to_parsername.vimwiki = "markdown"

configs.setup({
    ensure_installed = "all", -- one of "all" or a list of languages
    --[[ ignore_install = { "markdown", "phpdoc" }, -- List of parsers to ignore installing ]]
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
            node_incremental = ",",
            -- scope_incremental = "grc",
            node_decremental = "–",
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
                ["ab"] = "@block.outer", -- meh
                ["ib"] = "@block.inner",
                ["ac"] = "@call.outer",
                ["ic"] = "@call.inner",
                ["aC"] = "@comment.outer", -- only does one line
                ["iC"] = "@comment.outer",
                ["ai"] = "@conditional.outer", -- eh
                ["ii"] = "@conditional.inner",
                ["af"] = "@function.outer", -- eh
                ["if"] = "@function.inner",
                ["al"] = "@loop.outer", -- meh
                ["il"] = "@loop.inner",
                ["aa"] = "@parameter.outer",
                ["ia"] = "@parameter.inner",
                ["aS"] = "@statement.outer", -- meh
                ["iS"] = "@statement.outer",
            },
        },
        move = {
            enable = true,
            goto_next_start = {
                [",w"] = "@parameter.inner",
                [",v"] = "@function.outer",
                [",c"] = "@call.outer",
            },
            goto_next_end = {
                [",e"] = "@parameter.inner",
            },
            goto_previous_start = {
                [",b"] = "@parameter.inner",
                [",f"] = "@function.outer",
                [",d"] = "@call.outer",
            },
            goto_previous_end = {
                [",ge"] = "@parameter.inner",
            },
        },
    },
})

local status_ok, context = pcall(require, "treesitter-context")
if not status_ok then
    return
end

context.setup()
