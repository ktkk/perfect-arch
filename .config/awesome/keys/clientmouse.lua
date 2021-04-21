-- clientmouse.lua
-- Client mousebinds
local gears = require("gears")
local awful = require("awful")

local keys = RC.vars.keys

local module = {}

function module.get()
	local clientmouse = gears.table.join(
		--- LMB: 		Activate client
		awful.button({ }, 1,
			function (c)
				c:emit_signal("request::activate", "mouse_click", {raise = true})
			end
		),
		--- Super - LMB: 	Activate and move client
		awful.button({ keys.modkey }, 1,
			function (c)
				c:emit_signal("request::activate", "mouse_click", {raise = true})
				awful.mouse.client.move(c)
			end
		),
		-- Super - RMB: 	Activate and resize client
		awful.button({ keys.modkey }, 3,
			function (c)
				c:emit_signal("request::activate", "mouse_click", {raise = true})
				awful.mouse.client.resize(c)
			end
		)
	)

	return clientmouse
end

return setmetatable({}, { __call = function(_, ...) return module.get(...) end })
