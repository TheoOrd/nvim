local builtin = require('telescope.builtin')

require('telescope').setup{
	defaults = {
		prompt_prefix = "🔭 ",
		selection_caret = "👀 ",
		entry_prefix = "  ",
	}
}


vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', function()
	builtin.grep_string({ search = vim.fn.input('Grep > ') })
end)

vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('theo-lsp-attach', { clear = true }),
	callback = function(event)
		vim.keymap.set('n', 'gd', builtin.lsp_definition)
	end,
})
