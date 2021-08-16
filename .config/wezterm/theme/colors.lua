function get_color(name)
	local query = io.popen("xrdb -query"):read("*a")
	local color = query:match("%*" .. name .. ":%s*(#%x%x%x%x%x%x)")

	return color
end

local colors = {
	xbackground = get_color("background"),
	xforeground = get_color("foreground"),
	xcursorcolor = get_color("cursorColor"),
	xblack = { light = get_color("color0"), dark = get_color("color8") },
	xred = { light = get_color("color1"), dark = get_color("color9") },
	xgreen = { light = get_color("color2"), dark = get_color("color10") },
	xyellow = { light = get_color("color3"), dark = get_color("color11") },
	xblue = { light = get_color("color4"), dark = get_color("color12") },
	xmagenta = { light = get_color("color5"), dark = get_color("color13") },
	xcyan = { light = get_color("color6"), dark = get_color("color14") },
	xwhite = { light = get_color("color7"), dark = get_color("color15") },
}

local theme = {
	foreground = colors.xforeground,
	background = colors.xbackground,

	cursor_bg = colors.xcursorcolor,
	cursor_fg = colors.xbackground,
	cursor_border = colors.xcursorcolor,

	selection_fg = colors.xbackground,
	selection_bg = colors.xforeground,

	ansi = {
		colors.xblack.light,
		colors.xred.light,
		colors.xgreen.light,
		colors.xyellow.light,
		colors.xblue.light,
		colors.xmagenta.light,
		colors.xcyan.light,
		colors.xwhite.light,
	},
	brights = {
		colors.xblack.dark,
		colors.xred.dark,
		colors.xgreen.dark,
		colors.xyellow.dark,
		colors.xblue.dark,
		colors.xmagenta.dark,
		colors.xcyan.dark,
		colors.xwhite.dark,
	},

	tab_bar = {
		background = colors.xbackground,
		active_tab = { bg_color = colors.xbackground, fg_color = colors.xforeground },
		inactive_tab = { bg_color = colors.xblack.light, fg_color = colors.xwhite.dark },
		inactive_tab_hover = { bg_color = colors.xblack.dark, fg_color = colors.xwhite.light }
	}
}

return theme
