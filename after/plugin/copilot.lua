-- Copilot inside telescope

local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local conf = require('telescope.config').values

local copilot_chat_prompt = function()
	pickers.new({}, {
		prompt_title = 'Ask Copilot',
		finder = finders.new_table({
			results = {},
		}),
		sorter = conf.generic_sorter({}),
		attach_mappings = function(_, map)
			map('i', '<CR>', function(prompt_bufnr)
				local prompt = action_state.get_current_line()
				actions.close(prompt_bufnr)
				vim.cmd('CopilotChat ' .. prompt)
			end)
			return true
		end,
	}):find()
end

vim.keymap.set('n', '<leader>cc', function()
	copilot_chat_prompt()
end)
vim.keymap.set('n', '<leader>cx', ':CopilotChatToggle<CR>')
vim.keymap.set('v', '<leader>cc', ':CopilotChatExplain<CR>')

