local cmp = require("cmp")
local luasnip = require("luasnip")
local luasnip_loaders_from_vscode = require("luasnip.loaders.from_vscode")

luasnip_loaders_from_vscode.lazy_load()

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
            luasnip.lsp_expand(args.body)
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
        ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }), -- open the completion menu

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
