return {
  'neovim/nvim-lspconfig',
  config = function() vim.lsp.config['lua-language-server'] = {} end,
}
