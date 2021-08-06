local present, compe = pcall(require, "compe")
if not present then
	return
end

compe.setup {
	enabled = true,
	autocomplete = true,
	debug = false,
	preselect = "enable",
	throttle_time = 80,
	source_timeout = 200,
	incomplete_delay = 400,
	max_abbr_width = 100,
	max_kind_width = 100,
	max_menu_width = 100,
	documentation = true,

	source = {
		buffer = true,
		path = true,
		calc = true,
		nvim_lsp = true,
		nvim_lua = true,
		luasnip = true,
	}
}
