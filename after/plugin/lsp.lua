local cmp = require('cmp')
local luasnip = require('luasnip')
require('luasnip/loaders/from_vscode').lazy_load()

local check_backspace = function()
	local col = vim.fn.col '.' - 1
	return col == 0 or vim.fn.getLine('.'):sub(col, col):match '%s'
end

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
			luasnip.lsp_expand(args.body)
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
		{ name = 'luasnip' },
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

require('mason').setup()
