-- taglist.lua
-- Taglist module for statusbar
local gears = require("gears")
local awful = require("awful")

local keys = RC.vars.keys

local module = {}

function module.get()
	-- Create a wibox for each screen and add it
	local taglist_buttons = gears.table.join(
		-- LMB:			Go to tag
		awful.button({ }, 1,
			function(t)
				t:view_only()
			end),
		-- Super - LMB: 	Move focussed client to tag
		awful.button({ keys.modkey }, 1,
			function(t)
				if client.focus then
					client.focus:move_to_tag(t)
				end
			end),
		-- RMB: 		Toggle view tag
		awful.button({ }, 3, awful.tag.viewtoggle),
		-- Super - RMB: 	Toggle view client on tag
		awful.button({ keys.modkey }, 3,
			function(t)
				if client.focus then
					client.focus:toggle_tag(t)
				end
			end),
		-- Scrollup: 		View next tag
		awful.button({ }, 4,
			function(t)
				awful.tag.viewnext(t.screen)
			end),
		-- Scrolldown: 		View previous tag
		awful.button({ }, 5,
			function(t)
				awful.tag.viewprev(t.screen)
			end)
	)

	return taglist_buttons
end

return setmetatable({}, {__call = function(_, ...) return module.get(...) end })
