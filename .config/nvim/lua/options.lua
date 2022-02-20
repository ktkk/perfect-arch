local cmd = vim.cmd

local scopes = { o = vim.o, b = vim.bo, w = vim.wo }
local function opt(scope, key, value)
	scopes[scope][key] = value
	if scope ~= 'o' then scopes['o'][key] = value end -- also turn on value for other scopes
end

local set = vim.opt

-- Commands
cmd("syntax on")
cmd("filetype plugin indent on")

cmd("highlight ExtraWhiteSpace ctermbg=red guibg=red")
cmd("match ExtraWhiteSpace /\\s\\+$/")

-- Options
opt('o', "hidden", true)
opt('o', "splitbelow", true)
opt('o', "splitright", true)
opt('o', "showmode", false)
opt('o', "ruler", true)
opt('o', "mouse", 'a')
opt('o', "updatetime", 500)
opt('o', "termguicolors", true)

opt('b', "smartindent", true)
opt('b', "autoindent", true)
opt('b', "tabstop", 4)
opt('b', "softtabstop", 4)
opt('b', "shiftwidth", 4)

opt('w', "number", true)
opt('w', "relativenumber", true)
opt('w', "numberwidth", 3)
opt('w', "wrap", true)
opt('w', "signcolumn", "yes:1")

-- Global options
set.list = true
set.listchars = { tab = "→ ", space = "·", trail = "+", nbsp = "␣", precedes = "⇥", extends = "⇤" }
