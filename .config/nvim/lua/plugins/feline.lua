local present1, feline = pcall(require, "feline")
local present2, vi_mode = pcall(require, "feline.providers.vi_mode")
if not (present1 or present2) then
	return
end

local force_inactive = {
	filetypes = {
		"NvimTree",
		"dbui",
		"packer",
		"startify",
		"fugitive",
		"fugitiveblame",
	},
	buftypes = {
		"terminal",
	},
	bufnames = {},
}

local theme = {
	fg = colors.fg,
	bg = colors.bg,
	black = colors.black,
	skyblue = colors.light_blue,
	cyan = colors.cyan,
	green = colors.green,
	oceanblue = colors.blue,
	magenta = colors.magenta,
	orange = colors.light_red,
	red = colors.red,
	violet = colors.purple,
	white = colors.white,
	yellow = colors.yellow,
}

local vi_mode_colors = {
	NORMAL = "green",
	OP = "green",
	INSERT = "red",
	VISUAL = "skyblue",
	LINES = "skyblue",
	BLOCK = "skyblue",
	REPLACE = "violet",
	["V-REPLACE"] = "violet",
	ENTER = "cyan",
	MORE = "cyan",
	SELECT = "orange",
	COMMAND = "green",
	SHELL = "green",
	TERM = "green",
	NONE = "yellow",
}

local components = {
	active = { {}, {}, {} },
	inactive = { {}, {}, {} },
}

-- Active
-- Left
components.active[1][1] = {
	provider = '▋',
	hl = function()
		return {
			bg = vi_mode.get_mode_color(),
			fg = theme.white,
		}
	end,
}

components.active[1][2] = {
	provider = function()
		return vi_mode.get_vim_mode()
	end,
	hl = function()
		return {
			bg = vi_mode.get_mode_color(),
			style = "bold",
		}
	end,
	right_sep = {
		str = "right_rounded",
		hl = function()
			return {
				fg = vi_mode.get_mode_color(),
				bg = theme.black,
			}
		end,
	},
}

components.active[1][3] = {
	provider = "file_info",
	hl = {
		bg = theme.black,
	},
	left_sep = {
		str = ' ',
		hl = {
			fg = theme.red,
			bg = theme.black,
		}
	},
}

components.active[1][4] = {
	provider = "file_size",
	hl = {
		bg = theme.black,
	},
	left_sep = {
		str = ' ',
		hl = {
			fg = theme.red,
			bg = theme.black,
		},
	},
}

components.active[1][5] = {
	provider = '',
	hl = {
		fg = theme.red,
		bg = theme.black,
	},
	left_sep = {
		str = ' ',
		hl = {
			fg = theme.red,
			bg = theme.black,
		}
	},
	right_sep = {
		str = ' ',
		hl = {
			fg = theme.red,
			bg = theme.black,
		}
	},
}

components.active[1][6] = {
	provider = "git_branch",
	hl = {
		fg = theme.fg,
		bg = theme.black,
	},
}

components.active[1][7] = {
	provider = "git_diff_added",
	icon = " ",
	hl = {
		fg = theme.green,
		bg = theme.black,
	},
}

components.active[1][8] = {
	provider = "git_diff_changed",
	icon = " ",
	hl = {
		fg = theme.yellow,
		bg = theme.black,
	},
}

components.active[1][9] = {
	provider = "git_diff_removed",
	icon = " ",
	hl = {
		fg = theme.red,
		bg = theme.black,
	},
}

components.active[1][10] = {
	provider = ' ',
	hl = {
		fg = "NONE",
		bg = theme.black,
	},
	right_sep = {
		str = "right_rounded",
		hl = {
			fg = theme.black,
			bg = theme.bg,
		},
	},
}

-- Middle
components.active[2][1] = {
	provider = "diagnostic_hints",
	icon = " ",
	hl = {
		fg = theme.fg,
		bg = theme.bg,
	},
}

components.active[2][2] = {
	provider = "diagnostic_errors",
	icon = " ",
	hl = {
		fg = theme.red,
		bg = theme.bg,
	},
	left_sep = {
		str = ' ',
		bg = theme.bg,
	},
}

components.active[2][3] = {
	provider = "diagnostic_warnings",
	icon = " ",
	hl = {
		fg = theme.yellow,
		bg = theme.bg,
	},
	left_sep = {
		str = ' ',
		bg = theme.bg,
	},
}

-- Right
components.active[3][1] = {
	provider = "lsp_client_names",
	icon = " ",
	hl = {
		fg = theme.black,
		bg = theme.bg,
	},
	right_sep = {
		str = ' ',
		bg = theme.bg,
	}
}

components.active[3][2] = {
	provider = "file_format",
	hl = {
		fg = theme.fg,
		bg = theme.black,
	},
	left_sep = {
		str = "left_rounded",
		hl = {
			fg = theme.black,
			bg = theme.bg,
		},
	},
	right_sep = {
		str = ' ',
		hl = {
			bg = theme.black,
		},
	},
}

components.active[3][3] = {
	provider = "file_encoding",
	hl = {
		fg = theme.fg,
		bg = theme.skyblue,
	},
	left_sep = {
		str = "left_rounded",
		hl = {
			fg = theme.skyblue,
			bg = theme.black,
		},
	},
	right_sep = {
		str = ' ',
		hl = {
			bg = theme.skyblue,
		},
	},
}

components.active[3][4] = {
	provider = "position",
	hl = {
		fg = theme.fg,
		bg = theme.cyan,
	},
	left_sep = {
		str = "left_rounded",
		hl = {
			fg = theme.cyan,
			bg = theme.skyblue,
		},
	},
	right_sep = {
		str = ' ',
		hl = {
			bg = theme.cyan,
		},
	},
}

components.active[3][5] = {
	provider = "scroll_bar",
	hl = {
		fg = theme.yellow,
		bg = theme.cyan,
	},
}

-- Inactive
-- Left
components.inactive[1][1] = {
	provider = '▋',
	hl = {
			bg = theme.black,
			fg = theme.white,
	},
}

components.inactive[1][2] = {
	provider = "file_info",
	hl = {
		bg = theme.black,
	},
	left_sep = {
		str = ' ',
		hl = {
			fg = theme.red,
			bg = theme.black,
		}
	},
}

components.inactive[1][3] = {
	provider = "file_size",
	hl = {
		bg = theme.black,
	},
	left_sep = {
		str = ' ',
		hl = {
			fg = theme.red,
			bg = theme.black,
		},
	},
}

components.inactive[1][4] = {
	provider = '',
	hl = {
		fg = theme.red,
		bg = theme.black,
	},
	left_sep = {
		str = ' ',
		hl = {
			fg = theme.red,
			bg = theme.black,
		}
	},
	right_sep = {
		str = ' ',
		hl = {
			fg = theme.red,
			bg = theme.black,
		}
	},
}

components.inactive[1][5] = {
	provider = "git_branch",
	hl = {
		fg = theme.fg,
		bg = theme.black,
	},
}

components.inactive[1][6] = {
	provider = "git_diff_added",
	icon = " ",
	hl = {
		fg = theme.green,
		bg = theme.black,
	},
}

components.inactive[1][7] = {
	provider = "git_diff_changed",
	icon = " ",
	hl = {
		fg = theme.yellow,
		bg = theme.black,
	},
}

components.inactive[1][8] = {
	provider = "git_diff_removed",
	icon = " ",
	hl = {
		fg = theme.red,
		bg = theme.black,
	},
}

components.inactive[1][9] = {
	provider = ' ',
	hl = {
		fg = "NONE",
		bg = theme.black,
	},
	right_sep = {
		str = "right_rounded",
		hl = {
			fg = theme.black,
			bg = theme.bg,
		},
	},
}

-- Right
components.inactive[3][1] = {
	provider = "file_format",
	hl = {
		fg = theme.fg,
		bg = theme.black,
	},
	left_sep = {
		str = "left_rounded",
		hl = {
			fg = theme.black,
			bg = theme.bg,
		},
	},
	right_sep = {
		str = ' ',
		hl = {
			bg = theme.black,
		},
	},
}

components.inactive[3][2] = {
	provider = "file_encoding",
	hl = {
		fg = theme.fg,
		bg = theme.skyblue,
	},
	left_sep = {
		str = "left_rounded",
		hl = {
			fg = theme.skyblue,
			bg = theme.black,
		},
	},
	right_sep = {
		str = ' ',
		hl = {
			bg = theme.skyblue,
		},
	},
}

components.inactive[3][3] = {
	provider = "position",
	hl = {
		fg = theme.fg,
		bg = theme.cyan,
	},
	left_sep = {
		str = "left_rounded",
		hl = {
			fg = theme.cyan,
			bg = theme.skyblue,
		},
	},
	right_sep = {
		str = ' ',
		hl = {
			bg = theme.cyan,
		},
	},
}

components.inactive[3][4] = {
	provider = "scroll_bar",
	hl = {
		fg = theme.yellow,
		bg = theme.cyan,
	},
}

feline.setup({
	-- preset = "noicon",
	theme = theme,
	vi_mode_colors = vi_mode_colors,
	components = components,
	force_inactive = force_inactive,
})
