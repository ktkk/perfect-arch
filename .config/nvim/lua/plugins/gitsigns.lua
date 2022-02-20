local present, gitsigns = pcall(require, "gitsigns")
if not present then
	return
end

local cmd = vim.cmd

cmd("hi GitSignsAdd guifg=" .. colors.green .. " guibg=" .. colors.bg)
cmd("hi GitSignsChange guifg=" .. colors.yellow .. " guibg=" .. colors.bg)
cmd("hi GitSignsDelete guifg=" .. colors.red .. " guibg=" .. colors.bg)

-- cmd("hi GitsignsAddNr guifg=" .. colors.light_green .. " guibg=" .. colors.bg)
-- cmd("hi GitsignsChangeNr guifg=" .. colors.light_yellow .. " guibg=" .. colors.bg)
-- cmd("hi GitsignsDeleteNr guifg=" .. colors.light_red .. " guibg=" .. colors.bg)

gitsigns.setup {
	debug_mode = true,
	signs = {
		add				= { show_count = false, text = '│' },
		change			= { show_count = false, text = '│' },
		delete			= { show_count = true, text = '_' },
		topdelete		= { show_count = true, text = '-' },
		changedelete	= { show_count = true, text = '~' },
	},
	preview_config = {
		border = "rounded",
	},
	current_line_blame = true,
	current_line_blame_formatter_opts = {
		relative_time = true,
	},
	_extmark_signs = vim._has_signs_extmark,
}
