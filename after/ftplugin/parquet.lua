vim.cmd('%!duckdb -c "select * from file limit 100" %')
-- vim.bo.modifiable = false
vim.bo.readonly = true
