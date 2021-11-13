local api = vim.api

-- Map helper function
local function map(mode, lhs, rhs, opts)
	local options = { noremap = true }
	if opts then options = vim.tbl_extend("force", options, opts) end
	api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Normal mode mappings
map('n', "<C-t>", ":term<CR>") -- Open term with C-t

map('n', "<M-j>", ":m .+1<CR>==") -- Visual Studio style line moving
map('n', "<M-k>", ":m .-2<CR>==")

map('n', "<C-S-b>", ":make<CR>") -- Invoke make with C-S-b

-- Visual mode mappings
map('v', "<M-j>", ":m '>+1<CR>gv=gv") -- Visual Studio style line moving
map('v', "<M-k>", ":m '>-2<CR>gv=gv")

map('v', "<C-c>", "\"*y :let @+=@*<CR>")
