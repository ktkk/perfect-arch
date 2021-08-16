local awful = require("awful")

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

return utils
