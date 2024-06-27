return {
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
    event = "VeryLazy",

    config = function()
        local ufo = require("ufo")

        vim.keymap.set("n", "<Leader>>", ufo.openAllFolds, { desc = "Open All Folds" })
        vim.keymap.set("n", "<Leader><", ufo.closeAllFolds, { desc = "Close All Folds" })
        vim.keymap.set("n", "]z", ufo.goNextClosedFold, { desc = "Next Closed Fold" })
        vim.keymap.set("n", "[z", ufo.goPreviousClosedFold, { desc = "Previous Closed Fold" })
        vim.keymap.set("n", "h", function()
            local col = vim.api.nvim_win_get_cursor(0)[2]
            if col == 0 then
                vim.cmd.foldclose()
                return ""
            end
            return "h"
        end, { expr = true })

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
                local use_treesitter = { "markdown", "python" }
                if vim.tbl_contains(use_treesitter, ft) then return { "treesitter" } end
                return { "indent" }
            end,
            fold_virt_text_handler = make_fold_text,
            open_fold_hl_timeout = 50,
        })
    end,
}
