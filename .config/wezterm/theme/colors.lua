function get_color(name)
	-- Get the color from xrdb, read the output to a string and remove the newline character
	local color = io.popen("xrdb -query | grep " .. name .. " | awk '{print $2}'"):read("*a"):gsub('\n', '')

	return color
end

local colors = {
	foreground = get_color("foreground"),
	background = get_color("background")
}

return colors
