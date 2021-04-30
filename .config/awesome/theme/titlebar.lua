-- titlebar.lua
-- Titlebar config
local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
	-- Titlebar properties
	local titlebar = awful.titlebar(c, {
		position = "top"
	})

	-- Mouse actions
	local buttons = gears.table.join(
		-- Move while holding LMB on titlebar
		awful.button({ }, 1, function()
			c:emit_signal("request::activate", "titlebar", {raise = true})
			awful.mouse.client.move(c)
		end),
		-- Resize while holding RMB on titlebar
		awful.button({ }, 3, function()
			c:emit_signal("request::activate", "titlebar", {raise = true})
			awful.mouse.client.resize(c)
		end)
	)

	titlebar : setup {
		{ -- Left
			awful.titlebar.widget.iconwidget(c),

			awful.titlebar.widget.floatingbutton(c),
			awful.titlebar.widget.stickybutton(c),
			awful.titlebar.widget.ontopbutton(c),

			buttons = buttons,
			layout  = wibox.layout.fixed.horizontal
		},
		{ -- Middle
			{ -- Title
			     align  = "center",
			     widget = awful.titlebar.widget.titlewidget(c)
			},
			buttons = buttons,
			layout  = wibox.layout.flex.horizontal
		},
		{ -- Right
			awful.titlebar.widget.minimizebutton(c),
			awful.titlebar.widget.maximizedbutton(c),
			awful.titlebar.widget.closebutton(c),

			layout = wibox.layout.fixed.horizontal()
		},

		layout = wibox.layout.align.horizontal
	}
end)
