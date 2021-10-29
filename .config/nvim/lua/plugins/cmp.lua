local present, cmp = pcall(require, "cmp")
if not present then
	return
end

vim.opt.completeopt = { "menu", "menuone", "noselect" }

cmp.setup({
	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body)
		end,
	},
	mapping = {
		["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
		["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
		["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
		["<C-e>"] = cmp.mapping({
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		}),
		["<Tab>"] = cmp.mapping.confirm({ select = true }),
	},
	sources = cmp.config.sources(
	{
		{ name = "nvim_lsp" },
	},
	{
		{ name = "buffer" },
	})
})

-- Use buffer source for '/'
cmp.setup.cmdline('/', {
	sources = {
		{ name = "buffer" },
	}
})

-- Use cmdline & path source for ':'
cmp.setup.cmdline(':', {
	sources = cmp.config.sources({
		{ name = "path" }
	},
	{
		{ name = "cmdline" }
	}),
})
