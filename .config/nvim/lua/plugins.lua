local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local plugin_config_path = "plugins/"

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
		config = function() require(plugin_config_path .. "bufferline") end,
	}

	-- Status line
	use {
		"glepnir/galaxyline.nvim",
		config = function() require(plugin_config_path .. "galaxyline") end,
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
	}

	-- Theme
	use {
		"nekonako/xresources-nvim",
	}

	use {
		"kyazdani42/nvim-web-devicons",
		config = function() require(plugin_config_path .. "icons") end,
	}

	use {
		"nvim-treesitter/nvim-treesitter",
		event = "BufRead",
		config = function() require(plugin_config_path .. "treesitter") end,
	}

	-- Nvim tree sidebar
	--use {
	--	"kyazdani42/nvim-tree.lua",
	--	config = function() require("plugins/nvimtree") end,
	--}

	-- Completion
	use {
		"hrsh7th/nvim-cmp",
		config = function() require(plugin_config_path .. "cmp") end,
	}

	use {
		"hrsh7th/cmp-nvim-lsp",
		after = "nvim-cmp",
	}

	use {
		"hrsh7th/cmp-buffer",
		after = "nvim-cmp",
	}

	use {
		"hrsh7th/cmp-path",
		after = "nvim-cmp",
	}

	use {
		"hrsh7th/cmp-cmdline",
		after = "nvim-cmp",
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
		"ray-x/lsp_signature.nvim",
	}

	

	-- Convenience stuff
	use {
		"windwp/nvim-autopairs",
		config = function() require(plugin_config_path .. "autopairs") end,
	}

	use {
		"mhartington/formatter.nvim",
		config = function() require(plugin_config_path .. "formatter") end,
	}
end)
