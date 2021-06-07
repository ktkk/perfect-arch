-- clientkeys.lua
-- Client keybinds
local gears = require("gears")
local awful = require("awful")

local keys = RC.vars.keys

local module = {}

function module.get()
	local clientkeys = gears.table.join(
		-- Formatting
		-- awful.key({ MODIFIER KEYS }, KEY, FUNCTION, {description = DESCRIPTION, group = GROUP}),
		-- Description and group are displayed in the help menu

		-------------------------------------------------------------------------------------------
		-- Clients
		-- Super - B: 		Toggle fullscreen client
		awful.key({ keys.modkey, }, "b",
				function (c)
					c.fullscreen = not c.fullscreen
					c:raise()
				end,
			{description = "Toggle fullscreen", group = "client"}),
		-- Super - F: 		Toggle float client
		awful.key({ keys.modkey }, "f", awful.client.floating.toggle, {description = "toggle floating", group = "client"}),
		-- Super - Q: 		Close client
		awful.key({ keys.modkey, }, "q",
				function (c)
					c:kill()
				end,
			{description = "Close", group = "client"}),
		-- Super - A: 		Make client master
		awful.key({ keys.modkey, }, "A",
				function (c)
					c:swap(awful.client.getmaster())
				end,
			{description = "Move to master", group = "client"}),
		-- Super - >: 		Move client to next screen
		awful.key({ keys.modkey, }, ">",
				function (c)
					c:move_to_screen(c.screen.index + 1)
				end,
			{description = "Move to next screen", group = "client"}),
		-- Super - <: 		Move client to previous screen
		awful.key({ keys.modkey, }, "<",
				function (c)
					c:move_to_screen(c.screen.index - 1)
				end,
			{description = "Move to previous screen", group = "client"}),
		-- Super - T: 		Toggle keep on top
		awful.key({ keys.modkey, }, "t",
				function (c)
					c.ontop = not c.ontop
				end,
			{description = "Toggle keep on top", group = "client"}),
		-- Super - Ctrl - P: 	Toggle client titlebar
		awful.key({ keys.modkey, keys.ctrl }, "p",
				function (c)
					awful.titlebar.toggle(c)
				end,
			{description = "Toggle titlebar", group = "client"}),
		-- Super - N: 		Minimize client
		awful.key({ keys.modkey, }, "n",
				function (c)
					-- The client currently has the input focus, so it cannot be
					-- minimized, since minimized clients can't have the focus.
					c.minimized = true
				end,
			{description = "Minimize", group = "client"}),
		-- Super - M: 		Maximize client
		awful.key({ keys.modkey, }, "m",
				function (c)
					c.maximized = not c.maximized
					c:raise()
				end ,
			{description = "(Un)maximize", group = "client"}),
		-- Super - Ctrl - M: 	Maximize client vertically
		awful.key({ keys.modkey, keys.ctrl }, "m",
				function (c)
					c.maximized_vertical = not c.maximized_vertical
					c:raise()
				end ,
			{description = "(Un)maximize vertically", group = "client"}),
		-- Super - Shift - M: 	Maximize client horizontally
		awful.key({ keys.modkey, keys.shift }, "m",
				function (c)
					c.maximized_horizontal = not c.maximized_horizontal
					c:raise()
				end ,
			{description = "(Un)maximize horizontally", group = "client"})
	)

	return clientkeys
end

return setmetatable({}, { __call = function(_, ...) return module.get(...) end })
