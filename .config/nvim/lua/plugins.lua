local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then -- If packer is not already present
	execute("!git clone https://github.com/wbthomason/packer.nvim" .. ' ' .. install_path)
	execute("packadd packer.nvim")
end

vim.cmd("autocmd BufWritePost plugins.lua PackerCompile") -- Recompile packer when this file gets edited

return require("packer").startup(function(use)
	-- Let Packer manage itself
	use {
		"wbthomason/packer.nvim",
		event = "VimEnter"
	}

	-- Buffer bar
	use {
		"akinsho/nvim-bufferline.lua",
		config = function() require("plugins/bufferline") end,
	}

	-- Status line
	use {
		"glepnir/galaxyline.nvim",
		config = function() require("plugins/statusline") end,
	}

	-- Theme
	use {
		"nekonako/xresources-nvim",
	}

	use {
		"kyazdani42/nvim-web-devicons",
		config = function() require("plugins/icons") end,
	}

	use {
		"nvim-treesitter/nvim-treesitter",
		event = "BufRead",
		config = function() require("plugins/treesitter") end,
	}

	-- Nvim tree sidebar
	use {
		"kyazdani42/nvim-tree.lua",
		config = function() require("plugins/nvimtree") end,
	}

	-- LSP stuff
	use {
		"kabouzeid/nvim-lspinstall",
		event = "BufEnter",
	}

	use {
		"neovim/nvim-lspconfig",
		after = "nvim-lspinstall"
	}

	use {
		"hrsh7th/nvim-compe",
		event = "InsertEnter",
		config = function() require("plugins/compe") end,
	}

	-- Convenience stuff
	use {
		"windwp/nvim-autopairs",
	}

	use {
		"andymass/vim-matchup",
		event = "CursorMoved",
	}
end)
