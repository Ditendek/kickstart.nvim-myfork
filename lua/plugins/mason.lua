return {
    {
        "mason-org/mason.nvim",
        opts = {},
    },
    {
        "mason-org/mason-lspconfig.nvim",
        dependencies = {
            "neovim/nvim-lspconfig",
            "mason-org/mason.nvim",
        },
        opts = {
            ensure_installed = {
                "pyright",
                "lua_ls",
                -- "lua-language-server",
            },
        },
    },
}
