return {
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            -- Bracket completion:
            "windwp/nvim-autopairs",
            -- Completion sources:
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-cmdline",
            "dmitmel/cmp-cmdline-history",
            "rcarriga/cmp-dap",
            "hrsh7th/cmp-nvim-lsp-signature-help",
            -- Snippets:
            "L3MON4D3/LuaSnip",
            "rafamadriz/friendly-snippets",
        },
        event = "InsertEnter",

        config = function()
            local cmp = require("cmp")
            local autopairs = require("nvim-autopairs")

            local ls = require("luasnip")
            -- local ls_types = require("luasnip.util.types")
            local ls_loader_lua = require("luasnip.loaders.from_lua")
            local ls_loader_vscode = require("luasnip.loaders.from_vscode")

            -- Snippet sources:
            ls_loader_vscode.lazy_load()
            ls_loader_lua.lazy_load({ paths = vim.fn.stdpath("config") .. "/lua/snippets" })

            -- ls.config.set_config({
            --     history = true,
            --     updateevents = "TextChanged,TextChangedI",
            --     ext_opts = {
            --         [types.choiceNode] = {
            --             active = {
            --                 virt_text = { { " « ", "NonTest" } },
            --             },
            --         },
            --     },
            -- })

            -- Snippet keys:
            vim.keymap.set({ "i", "s" }, "<Tab>", function()
                if ls.expand_or_jumpable() then
                    ls.expand_or_jump()
                end
            end, { silent = true })
            vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
                if ls.jumpable(-1) then
                    ls.jump(-1)
                end
            end, { silent = true })
            vim.keymap.set("i", "<C-l>", function()
                if ls.choice_active() then
                    ls.change_choice(1)
                end
            end)

            cmp.setup({
                -- for cmp-dap:
                enabled = function()
                    return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt" or require("cmp_dap").is_dap_buffer()
                end,
                formatting = {
                    format = function(entry, vim_item)
                        if entry.source.name ~= "nvim_lsp" then
                            if vim_item.kind ~= "Text" then
                                vim_item.kind = string.format("%s %s", vim_item.kind, entry.source.name)
                            else
                                vim_item.kind = entry.source.name
                            end
                        end
                        return vim_item
                    end,
                },
                snippet = {
                    expand = function(args)
                        ls.lsp_expand(args.body)
                    end,
                },
                window = {
                    -- no border for pop-up menu; but border for documentation
                    documentation = {
                        border = vim.g.small_border,
                        winhighlight = "", -- works for some reason?
                    },
                },
                mapping = {
                    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete({}), { "i", "c" }), -- open the completion menu
                    ["<Up>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
                    ["<Down>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
                    ["<Left>"] = cmp.mapping(cmp.mapping.close(), { "i", "c" }),
                    ["<Right>"] = cmp.mapping(
                        cmp.mapping.confirm({
                            behavior = cmp.ConfirmBehavior.Replace,
                            select = true,
                        }),
                        { "i", "c" }
                    ),
                    ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
                    ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
                },
                sources = cmp.config.sources({
                    -- order matters, sets sorting preference
                    { name = "nvim_lsp_signature_help" },
                    -- { name = "luasnip" },
                    { name = "nvim_lsp" },
                    { name = "path" },
                }, {
                    -- these get shown if the above sources return no results
                    { name = "buffer", max_item_count = 5 },
                }),
            })
            cmp.setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
                sources = {
                    { name = "dap" },
                },
            })
            cmp.setup.cmdline(":", {
                sources = cmp.config.sources({
                    { name = "path" },
                }, {
                    { name = "cmdline", keyword_length = 3 },
                }, {
                    { name = "cmdline_history", keyword_length = 3 },
                }),
            })

            autopairs.setup({
                check_ts = true,
                ts_config = {
                    lua = { "string", "source" },
                    javascript = { "string", "template_string" },
                    java = false,
                },
                disable_filetype = { "TelescopePrompt", "spectre_panel" },
                fast_wrap = {
                    map = "<M-e>",
                    chars = { "{", "[", "(", '"', "'" },
                    pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
                    offset = 0, -- Offset from pattern match
                    end_key = "$",
                    keys = "qwertyuiopzxcvbnmasdfghjkl",
                    check_comma = true,
                    highlight = "PmenuSel",
                    highlight_grey = "LineNr",
                },
            })
            local autopairs_cmp = require("nvim-autopairs.completion.cmp")
            cmp.event:on("confirm_done", autopairs_cmp.on_confirm_done({ map_char = { tex = "" } }))
        end,
    },
}
