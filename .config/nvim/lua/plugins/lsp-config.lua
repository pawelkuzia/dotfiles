return {
	{
		"williamboman/mason.nvim",
		lazy = false,
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		opts = {
			auto_install = true,
		},
	},
	{
		"neovim/nvim-lspconfig",
		lazy = false,
    dependencies = { 'saghen/blink.cmp' },
		config = function()
			-- local capabilities = require("cmp_nvim_lsp").default_capabilities()
	     local capabilities= require("blink.cmp").get_lsp_capabilities()
			local lspconfig = require("lspconfig")
			lspconfig.ts_ls.setup({
				capabilities = capabilities,
			})
			lspconfig.solargraph.setup({
				capabilities = capabilities,
			})
			lspconfig.html.setup({
				capabilities = capabilities,
			})
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
			})
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
		end,
	},
  -- {
--   'neovim/nvim-lspconfig',
--   dependencies = { 'saghen/blink.cmp' },
--
--   -- example using `opts` for defining servers
--   opts = {
--     servers = {
--       lua_ls = {}
--     }
--   },
--   config = function(_, opts)
--     local lspconfig = require('lspconfig')
--     for server, config in pairs(opts.servers) do
--       -- passing config.capabilities to blink.cmp merges with the capabilities in your
--       -- `opts[server].capabilities, if you've defined it
--       config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
--       lspconfig[server].setup(config)
--     end
--   end
--
--  -- example calling setup directly for each LSP
--   config = function()
--     local capabilities = require('blink.cmp').get_lsp_capabilities()
--     local lspconfig = require('lspconfig')
--
--     lspconfig['lua_ls'].setup({ capabilities = capabilities })
--   end
-- }
}
