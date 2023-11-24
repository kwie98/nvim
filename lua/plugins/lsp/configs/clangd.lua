return {
    -- workaround for "warning: multiple different client offset_encodings detected for buffer, this is not supported
    -- yet"
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/issues/428
    capabilities = {
        offsetEncoding = { "utf-16" },
    },
}
