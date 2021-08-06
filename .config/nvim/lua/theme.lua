local present, base16 = pcall(require, "base16")

local function get_color(name)
	local query = io.popen("xrdb -query"):read("*a")
	local color = query:match("%*" .. name .. ":%s*(#%x%x%x%x%x%x)")

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

local theme = "xresources"
base16.themes[theme] = {
	base00 = xcolors.xbackground, 	-- background
	base01 = xcolors.xblack.dark, 	-- lighter background
	base02 = xcolors.xblack.light, 	-- selection
	base03 = xcolors.xgreen.light, 	-- comments
	base04 = xcolors.xblue.light, 	-- dark foreground
	base05 = xcolors.xforeground, 	-- foreground
	base06 = xcolors.xwhite.light, 	-- light foreground
	base07 = xcolors.xblack.light, 	-- light background

	base08 = xcolors.xred.dark, 	-- variables
	base09 = xcolors.xblue.dark, 	-- ints
	base0A = xcolors.xmagenta.dark, -- classes
	base0B = xcolors.xgreen.dark, 	-- strings
	base0C = xcolors.xyellow.dark, 	-- esc chars
	base0D = xcolors.xcyan.dark, 	-- functions
	base0E = xcolors.xyellow.dark, 	-- keywords
	base0F = xcolors.xred.dark, 	-- embedded language tags (html)
}

if present then
	base16(base16.themes[theme], true)
	return true
else
	return false
end
