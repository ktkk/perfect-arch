-- tasklist.lua
-- Tasklist module for statusbar
local gears = require("gears")
local awful = require("awful")

local module = {}

function module.get()
	local tasklist_buttons = gears.table.join(
		-- LMB: 		Minimize if focussed, Focus if not focussed
		awful.button({ }, 1,
			function(c)
				if c == client.focus then
					c.minimized = true
				else
					c:emit_signal(
						"request::activate",
						"tasklist",
						{raise = true}
					)
				end
			end),
		-- MMB: 		Close client
		awful.button({ }, 2,
			function(c)
				c:kill()
			end),
		-- RMB: 		Show list of client
		awful.button({ }, 3,
			function()
				awful.menu.client_list({ theme = { width = 250 } })
			end),
		-- Scrollup: 		Focus next client
		awful.button({ }, 4,
			function()
				awful.client.focus.byidx(1)
			end),
		-- Scrolldown: 		Focus previous client
		awful.button({ }, 5,
			function()
				awful.client.focus.byidx(-1)
			end)
	)

	return tasklist_buttons
end

return setmetatable({}, { __call = function(_, ...) return module.get(...) end })
