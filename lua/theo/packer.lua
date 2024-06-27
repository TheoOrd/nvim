vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'
	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.8',
		requires = { { 'nvim-lua/plenary.nvim' } }
	}
	use {
		'rose-pine/neovim',
		as = 'rose-pine',
		config = function()
			vim.cmd('colorscheme rose-pine')
		end
	}
	use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate'})
	use 'nvim-treesitter/playground'
	use'theprimeagen/harpoon'
	use'mbbill/undotree'
	use'tpope/vim-fugitive'
	use {
		'vonheikemen/lsp-zero.nvim',
		branch = 'v3.x',
		requires = {
			{ 'williamboman/mason.nvim' },
			{ 'williamboman/mason-lspconfig.nvim' },
			{ 'neovim/nvim-lspconfig' },
			{ 'hrsh7th/nvim-cmp' },
			{ 'L3MON4D3/LuaSnip' },
		}
	}
end)
