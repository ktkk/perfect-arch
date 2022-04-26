local awful = require("awful")
local gears = require("gears")
local naughty = require('naughty')
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

function send_screenshot_notif(file_loc, message)
	local open_image = naughty.action {
		name = "Open",
	   	icon_only = false,
	}
	
	local delete_image = naughty.action {
		name = "Delete",
	   	icon_only = false,
	}
	
	-- Execute the callback when 'Open' is pressed
	open_image:connect_signal("invoked", function()
		awful.spawn("xdg-open " .. file_loc, false)
	end)
	
	-- Execute the callback when 'Delete' is pressed
	delete_image:connect_signal("invoked", function()
		awful.spawn("rm -f " .. file_loc, false)
	end)
	
	-- Show notification
	naughty.notification ({
		app_name = "Screenshot Tool",
		icon = file_loc,
		timeout = 10,
		title = "<b>Screenshot!</b>",
		message = message,
		actions = { open_image, delete_image }
	})	
end

local screenshot_dir = "~/Pictures/Screenshots/"

-- Selection screenshot
function utils.selection_screenshot()
	awful.util.spawn("scrot -se 'xclip -selection c -t image/png < $f && mv $f " .. screenshot_dir .. "'", false)
	
	local screenshot = io.popen("ls -1 -t " .. screenshot_dir .. " | head -1")
	local message = "Selection screenshot saved and copied to clipboard!"
	
	send_screenshot_notif(screenshot, message)
end

-- Fullscreen screenshot
function utils.fullscreen_screenshot()
	awful.util.spawn("scrot -e 'xclip -selection c -t image/png < $f && mv $f " .. screenshot_dir .. "'", false)
	
	local screenshot = io.popen("ls -1 -t " .. screenshot_dir .. " | head -1")
	local message = "Fullscreen screenshot saved and copied to clipboard!"
	
	send_screenshot_notif(screenshot, message)
end

return utils
