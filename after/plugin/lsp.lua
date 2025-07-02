local cmp = require('cmp')
local luasnip = require('luasnip')
require('luasnip/loaders/from_vscode').lazy_load()

local kind_icons = {
	Text         = '🐖',
	Method       = '🔧',
	Function     = '⚙️',
	Constructor  = '🏗️',
	Field        = '🔑',
	Variable     = '🔣',
	Class        = '🏛️',
	Interface    = '💻',
	Module       = '📦',
	Property     = '🏷️',
	Unit         = '📏',
	Value        = '💎',
	Enum         = '🔢',
	Keyword      = '🔤',
	Snippet      = '✂️',
	Color        = '🎨',
	File         = '📄',
	Reference    = '🔗',
	Folder       = '📁',
	EnumMember   = '🔸',
	Constant     = '🔒',
	Struct       = '🧱',
	Event        = '⚡',
	Operator     = '➕',
	TypeParameter= '🔠',
}

cmp.setup {
	snippet = {
		expand = function(args)
			-- luasnip.lsp_expand(args.body)
			-- maybe later
		end,
	},
	mapping = {
		['<C-k>'] = cmp.mapping.select_prev_item(),
		['<C-j>'] = cmp.mapping.select_next_item(),
		['<C-y>'] = cmp.config.disable,
		['<CR>'] = cmp.mapping.confirm { select = true },
		['<Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expandable() then
				luasnip.expand()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { 'i', 's' }),
		['<S-Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { 'i', 's' }),
	},
	formatting = {
		fields = { 'kind', 'abbr', 'menu' },
		format = function(entry, vim_item)
			local k = vim_item.kind
			vim_item.kind = (kind_icons[k] or '?') .. ' ';
			vim_item.menu = ({
				nvim_lsp = '[LSP]',
				nvim_lua = '[NVIM_LUA]',
				luasnip = '[Snippet]',
				buffer = '[Buffer]',
				path = '[Path]',
			})[entry.source.name]
			return vim_item
		end,
	},
	sources = {
		{ name = 'nvim_lsp' },
		{ name = 'nvim_lua' },
		{ name = 'buffer' },
		{ name = 'path' },
	},
	confirm_opts = {
		behavior = cmp.ConfirmBehavior.Replace,
		select = false,
	},
	window = {
		documentation = cmp.config.window.bordered()
	},
	experimental = {
		ghost_text = false,
		native_menu = false,
	}
}

local signs = { Error = '❌', Warn = '⚠️', Hint = '💡', Info = 'ℹ️' }
for type, icon in pairs(signs) do
	local hl = 'DiagnosticSign' .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
end

vim.diagnostic.config({
	virtual_text = {
		prefix = '🔸',
	},
	signs = true,
	update_in_insert = false,
	underline = true,
	severity_sort = true,
})

local on_attach = function(_, bufnr)
	local bufopts = { noremap=true, silent=true, buffer=bufnr }
	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
	vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
	vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
	vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
	vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
	vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
	vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, bufopts)
	vim.keymap.set('n', ']d', vim.diagnostic.goto_next, bufopts)
end

require('mason').setup()
require('mason-lspconfig').setup {
	ensure_installed = { 'ts_ls', 'pyright', 'lua_ls' },
	handlers = {
		function(server_name)
			vim.lsp.enable(server_name, {
				on_attach = on_attach,
			})
		end,

		['lua_ls'] = function()
			vim.lsp.enable('lua_ls', {
				on_attach = on_attach,
				settings = {
					Lua = {
						diagnostics = {
							globals = { 'vim' },
						},
					},
				},
			})
		end,
	},
}

vim.api.nvim_create_user_command('ProjectDiagnostics', function()
	vim.diagnostic.setqflist()
	vim.cmd('copen')
end, {})
vim.keymap.set('n', '<leader>pd', ':ProjectDiagnostics<CR>')
