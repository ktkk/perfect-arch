local present1, gl = pcall(require, "galaxyline")
local present2, condition = pcall(require, "galaxyline.condition")
if not (present1 or present2) then
	return
end

local gls = gl.section

gl.short_line_list = { "LuaTree" }

local buffer_not_empty = function()
	if vim.fn.empty(vim.fn.expand("%:t")) ~= 1 then
		return true
	end
	return false
end

local check_width = function()
	local sqeeze_width = vim.fn.winwidth(0) / 2
	if sqeeze_width > 40 then
		return true
	end
	return false
end

-- Left
gls.left[1] = {
	LeftBegin = {
		provider = function() return '▋' end,
		highlight = { colors.green, colors.black },
	},
}

gls.left[2] = {
	ViMode = {
		provider = function()
			local alias = { n = "NORMAL", i = "INSERT", c = "COMMAND", v = "VISUAL", V = "VISUAL LINE", [''] = "VISUAL BLOCK" }
			return alias[vim.fn.mode()]
		end,
		separator = " ",
		separator_highlight = { colors.black, function()
			if not buffer_not_empty() then
				return colors.purple
			end
			return colors.bg
		end
		},
		highlight = { colors.fg, colors.black, "bold" },
	},
}

gls.left[3] = {
	FileIcon = {
		provider = "FileIcon",
		condition = buffer_not_empty,
		highlight = { require("galaxyline.provider_fileinfo").get_file_icon_color, colors.bg },
	},
}

gls.left[4] = {
	FileName = {
		provider = { "FileName", "FileSize" },
		condition = buffer_not_empty,
		separator = '',
		separator_highlight = { colors.black, colors.bg },
		highlight = { colors.fg, colors.bg },
	},
}

gls.left[5] = {
	GitIcon = {
		provider = function() return "  " end,
		condition = buffer_not_empty,
		highlight = { colors.red, colors.black },
	},
}

gls.left[6] = {
	GitBranch = {
		provider = "GitBranch",
		condition = buffer_not_empty,
		highlight = { colors.fg, colors.black },
	},
}

gls.left[7] = {
	DiffAdd = {
		provider = "DiffAdd",
		condition = check_width,
		icon = " ",
		highlight = { colors.green, colors.black },
	},
}

gls.left[8] = {
	DiffModified = {
		provider = "DiffModified",
		condition = check_width,
		icon = " ",
		highlight = { colors.yellow, colors.black },
	},
}

gls.left[9] = {
	DiffRemove = {
		provider = "DiffRemove",
		condition = check_width,
		icon = " ",
		highlight = { colors.red, colors.black },
	},
}

gls.left[10] = {
	LeftEnd = {
		provider = function() return ' ' end,
		separator = '',
		separator_highlight = { colors.black, colors.bg },
		highlight = { colors.black, colors.black },
	},
}

gls.left[11] = {
	DiagnosticError = {
		provider = "DiagnosticError",
		icon = "  ",
		highlight = { colors.red, colors.bg },
	},
}

gls.left[12] = {
	Space = {
		provider = function() return ' ' end,
	},
}

gls.left[13] = {
	DiagnosticWarn = {
		provider = "DiagnosticWarn",
		icon = "  ",
		highlight = { colors.yellow, colors.bg },
	},
}

-- Right
gls.right[1] = {
	LspClient = {
		provider = "GetLspClient",
		icon = "  ",
		highlight = { colors.grey, colors.bg },
	}
}

gls.right[2] = {
	FileFormat = {
		provider = { "FileFormat", "FileEncode" },
		separator = " ",
		separator_highlight = { colors.black, colors.bg },
		separator_highlight = { colors.light_blue, colors.bg },
		highlight = { colors.fg, colors.light_blue },
	},
}

gls.right[3] = {
	LineInfo = {
		provider = "LineColumn",
		separator = " ",
		separator_highlight = { colors.blue, colors.light_blue },
		highlight = { colors.fg, colors.blue },
	},
}

gls.right[4] = {
	Percent = {
		provider = "LinePercent",
		separator = '',
		separator_highlight = { colors.light_cyan, colors.blue },
		highlight = { colors.fg, colors.light_cyan },
	},
}

gls.right[5] = {
	ScrollBar = {
		provider = "ScrollBar",
		highlight = { colors.yellow, colors.light_cyan },
	},
}

-- Special buffers
gls.short_line_left[1] = {
	BufferType = {
		provider = "FileTypeName",
		separator = '',
		separator_highlight = { colors.purple, colors.bg },
		highlight = { colors.grey, colors.purple },
	},
}

gls.short_line_right[1] = {
	BufferIcon = {
		provider = "BufferIcon",
		separator = '',
		separator_highlight = { colors.purple, colors.bg },
		highlight = { colors.grey, colors.purple },
	},
}
