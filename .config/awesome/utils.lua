local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")

local utils = {}

-- Get the volume from amixer
function utils.get_volume()
	local query = io.popen("amixer sget Master"):read("*a")
	return tonumber(query:match("(%d?%d?%d)%%"))
end

-- Set the volume with pactl
-- And emit refresh signal
function utils.increase_volume(amount)
	awful.spawn.easy_async_with_shell("pactl set-sink-volume @DEFAULT_SINK@ +" .. amount .. '%',
		function() awesome.emit_signal("volume_refresh") end)
end

function utils.decrease_volume(amount)
	awful.spawn.easy_async_with_shell("pactl set-sink-volume @DEFAULT_SINK@ -" .. amount .. '%',
		function() awesome.emit_signal("volume_refresh") end)
end

-- Get muted status from amixer
function utils.get_muted()
	local query = io.popen("amixer sget Master"):read("*a")
	local status = query:match("%[(o[^%]]*)%]")

	if status:find("on", 1, true) then
		return false
	end
	return true
end

-- Toggle mute with pactl
function utils.toggle_muted()
	awful.spawn.easy_async_with_shell("pactl set-sink-mute @DEFAULT_SINK@ toggle",
		function() awesome.emit_signal("volume_refresh") end)
end

-- Enable rounded corners on windows
function utils.enable_rounding()
	local function rounded_rect(radius)
		return function(cr, width, height)
			gears.shape.rounded_rect(cr, width, height, radius)
		end
	end

	if beautiful.border_radius and beautiful.border_radius > 0 then
		client.connect_signal("manage", function(c, startup)
			if not c.fullscreen and not c.maximized then
				c.shape = rounded_rect(beautiful.border_radius)
			end
		end)

		local function no_round_corners(c)
			if c.fullscreen or c.maximized then
				c.shape = gears.shape.rectangle
			else
				c.shape = rounded_rect(beautiful.border_radius)
			end
		end

		client.connect_signal("property:fullscreen", no_round_corners)
		client.connect_signal("property:maximized", no_round_corners)
	end
end

-- Selection screenshot
function utils.selection_screenshot()
	awful.util.spawn("scrot -se 'xclip -selection c -t image/png < $f && mv $f ~/Pictures/Screenshots/'", false)
end

-- Fullscreen screenshot
function utils.fullscreen_screenshot()
	awful.util.spawn("scrot -e 'xclip -selection c -t image/png < $f && mv $f ~/Pictures/Screenshots/'", false)
end

return utils
