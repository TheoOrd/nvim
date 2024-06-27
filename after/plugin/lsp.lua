local lsp = require('lsp-zero')

lsp.on_attach(function(client, bufnr)
	lsp.default_keymaps({ buffer = bufnr })
	-- add custom key bindings here
end)

require('mason').setup({})
require('mason-lspconfig').setup({
	ensure_installed = { 'biome' },
	handlers = {
		function(server_name)
			require('lspconfig')[server_name].setup({})
		end,
	},
})

lsp.set_preferences {
	sign_icons = { }
}
