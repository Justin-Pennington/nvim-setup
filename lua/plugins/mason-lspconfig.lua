return {
	"mason-org/mason.nvim",
	"mason-org/mason-lspconfig.nvim",
	"neovim/nvim-lspconfig",

	require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "eslint" },
	}),
}
