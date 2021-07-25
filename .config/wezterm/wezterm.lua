local wezterm = require("wezterm")
local theme = require("theme")

return {
	colors = theme.colors,

	front_end = "OpenGL",
	enable_wayland = false,

	check_for_updates = false,
	window_close_confirmation = "NeverPrompt",
}
