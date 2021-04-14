-- bindtotags.lua
-- Module for binding keys to tags
local gears = require("gears")
local awful = require("awful")

local keys = rc.vars.keys

local M = {}

function M.get(globalkeys)
	-- Bind all key numbers to tags.
	-- Be careful: we use keycodes to make it work on any keyboard layout.
	-- This should map on the top row of your keyboard, usually 1 to 9.
	for i = 1, 9 do
	    globalkeys = gears.table.join(globalkeys,
		-- Super - [1-9]: 		View tag only.
		awful.key({ keys.modkey }, "#" .. i + 9,
				function ()
					local screen = awful.screen.focused()
					local tag = screen.tags[i]
					if tag then
					   tag:view_only()
					end
				end,
			{description = "view tag #"..i, group = "tag"}),
		-- Super - Ctrl - [1-9]: 	Toggle tag display.
		awful.key({ keys.modkey, keys.ctrl }, "#" .. i + 9,
				function ()
					local screen = awful.screen.focused()
					local tag = screen.tags[i]
					if tag then
						awful.tag.viewtoggle(tag)
					end
				end,
			{description = "toggle tag #" .. i, group = "tag"}),
		-- Super - Shift - [1-9]: 	Move client to tag.
		awful.key({ keys.modkey, keys.shift }, "#" .. i + 9,
				function ()
					if client.focus then
						local tag = client.focus.screen.tags[i]
						if tag then
							client.focus:move_to_tag(tag)
						end
					end
				end,
			{description = "move focused client to tag #"..i, group = "tag"}),
		-- Super - Ctrl - Shift - [1-9]: Toggle tag on focused client.
		awful.key({ keys.modkey, keys.ctrl, keys.shift }, "#" .. i + 9,
				function ()
					if client.focus then
					local tag = client.focus.screen.tags[i]
						if tag then
							client.focus:toggle_tag(tag)
						end
					end
				end,
		 	{description = "toggle focused client on tag #" .. i, group = "tag"})
		)
	end

	return globalkeys
end

return setmetatable({}, { __call = function(_, ..) return M.get(...) end })	
