local builtin = require('telescope.builtin')

require('telescope').setup{
	defaults = {
		prompt_prefix = "🔭 ",
		selection_caret = "👀 ",
		entry_prefix = "  ",
	}
}

vim.api.nvim_create_user_command('ProjectReplace', function(args)
	vim.cmd(string.format('vimgrep /%s/ `find . -type f -not -path \'*/node_modules/*\' -not -path \'*/.git/*\'`', args.fargs[1]))
	vim.cmd('copen');
	local confirm_flag = args.fargs[3] == 'a' and 'g' or 'gc'
	vim.cmd(string.format('cfdo %%s/%s/%s/%s | update', args.fargs[1], args.fargs[2], confirm_flag))
end, { nargs = '+' })

vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', function()
	builtin.grep_string({ search = vim.fn.input('Grep > ') })
end)
vim.keymap.set('n', '<leader>pr', ':ProjectReplace ')
