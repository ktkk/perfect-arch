local wezterm = require("wezterm")
local theme = require("theme")

-- Font fallback
function font_with_fallback(name, params)
	local names = { name, "FiraCode" }
	return wezterm.font_with_fallback(names, params)
end

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	if tab.is_active then
		return {
			{ text = " " .. tab.active_pane.title .. " " },
		}
	end

	return tab.active_pane.title
end)

return {
	-- Colors
	colors = theme.colors,

	-- Fonts
	font = font_with_fallback(theme.fonts.regular_font),
	font_rules = {
		{
			italic = true,
			font = font_with_fallback(theme.fonts.italic_font, { italic = true }),
		},
		{
			intensity = "Bold",
			font = font_with_fallback(theme.fonts.bold_font, { bold = true }),
		},
		{
			italic = true,
			intensity = "Bold",
			font = font_with_fallback(theme.fonts.bold_italic_font, { bold = true, italic = true }),
		},
		{
			intensity = "Half",
			font = font_with_fallback(theme.fonts.regular_font),
		}
	},
	font_size = theme.fonts.size,

	-- Cursor
	default_cursor_style = "BlinkingBlock",

	-- Rendering
	front_end = "Software",
	enable_wayland = false,

	-- Tabs
	enable_tab_bar = true,
	hide_tab_bar_if_only_one_tab = true,
	show_tab_index_in_tab_bar = false,

	-- Other
	check_for_updates = false,
	window_close_confirmation = "NeverPrompt",
	term = "wezterm"
}
