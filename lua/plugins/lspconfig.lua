-- return {
--   'neovim/nvim-lspconfig',
--   config = function() vim.lsp.config['lua-language-server'] = {} end,
-- }
-- return {
--     'neovim/nvim-lspconfig',
--
--     config = function()
--         vim.lsp.config('lua_ls', {})
--         vim.lsp.enable('lua_ls')
--
--         vim.lsp.config('clangd', {})
--         vim.lsp.enable('clangd')
--     end,
-- }
return {
    "neovim/nvim-lspconfig",

    config = function()
        vim.lsp.config("lua-language-server", {})
        vim.lsp.enable("lua-language-server")

        vim.lsp.config("clangd", {})
        vim.lsp.enable("clangd")
    end,
}
