return {
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
    event = "VeryLazy",

    config = function()
        local ufo = require("ufo")

        -- Folding:
        -- vim.opt.foldcolumn = "1"
        vim.opt.foldlevel = 20
        -- vim.opt.foldenable = true

        vim.keymap.set("n", "-", vim.cmd.foldclose)
        vim.keymap.set("n", "+", vim.cmd.foldopen)
        vim.keymap.set("n", "<Leader>+", ufo.openAllFolds, { desc = "Open All Folds" })
        vim.keymap.set("n", "<Leader>-", ufo.closeAllFolds, { desc = "Close All Folds" })
        vim.keymap.set("n", "]z", ufo.goNextClosedFold, { desc = "Next Closed Fold" })
        vim.keymap.set("n", "[z", ufo.goPreviousClosedFold, { desc = "Previous Closed Fold" })

        local function make_fold_text(virtText, lnum, endLnum, width, truncate)
            local newVirtText = {}
            local suffix = (" …  [%d lines]"):format(endLnum - lnum)
            local sufWidth = vim.fn.strdisplaywidth(suffix)
            local targetWidth = width - sufWidth
            local curWidth = 0
            for _, chunk in ipairs(virtText) do
                local chunkText = chunk[1]
                local chunkWidth = vim.fn.strdisplaywidth(chunkText)
                if targetWidth > curWidth + chunkWidth then
                    table.insert(newVirtText, chunk)
                else
                    chunkText = truncate(chunkText, targetWidth - curWidth)
                    local hlGroup = chunk[2]
                    table.insert(newVirtText, { chunkText, hlGroup })
                    chunkWidth = vim.fn.strdisplaywidth(chunkText)
                    -- str width returned from truncate() may less than 2nd argument, need padding
                    if curWidth + chunkWidth < targetWidth then
                        suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
                    end
                    break
                end
                curWidth = curWidth + chunkWidth
            end
            table.insert(newVirtText, { suffix, "MoreMsg" })
            return newVirtText
        end

        ufo.setup({
            provider_selector = function(_, ft, _)
                local lsp_without_folding = { "markdown", "python", "sh" }
                if vim.tbl_contains(lsp_without_folding, ft) then return { "treesitter", "indent" } end
                return { "lsp" }
            end,
            fold_virt_text_handler = make_fold_text,
            open_fold_hl_timeout = 100,
        })
    end,
}
