function get_color(name)
	local query = io.popen("xrdb -query"):read("*a")
	local color = query:match("*" .. name .. ":%s*(#%x%x%x%x%x%x)")

	return color
end

local xcolors = {
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

local colors = {
	foreground = xcolors.xforeground,
	background = xcolors.xbackground,

	cursor_bg = xcolors.xcursorcolor,
	cursor_fg = xcolors.xbackground,
	cursor_border = xcolors.xcursorcolor,

	selection_fg = xcolors.xbackground,
	selection_bg = xcolors.xforeground,

	ansi = {
		xcolors.xblack.light,
		xcolors.xred.light,
		xcolors.xgreen.light,
		xcolors.xyellow.light,
		xcolors.xblue.light,
		xcolors.xmagenta.light,
		xcolors.xcyan.light,
		xcolors.xwhite.light,
	},
	brights = {
		xcolors.xblack.dark,
		xcolors.xred.dark,
		xcolors.xgreen.dark,
		xcolors.xyellow.dark,
		xcolors.xblue.dark,
		xcolors.xmagenta.dark,
		xcolors.xcyan.dark,
		xcolors.xwhite.dark,
	},

	tab_bar = {
		background = xcolors.xbackground,
		active_tab = { bg_color = xcolors.xbackground, fg_color = xcolors.xforeground },
		inactive_tab = { bg_color = xcolors.xblack.light, fg_color = xcolors.xwhite.dark },
		inactive_tab_hover = { bg_color = xcolors.xblack.dark, fg_color = xcolors.xwhite.light }
	}
}

return colors
