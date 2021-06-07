-- statusbar.lua
-- Statusbar config
local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")

local theme = {
	taglist 	= require("theme.taglist"),
	tasklist 	= require("theme.tasklist")
}

local taglist_buttons = theme.taglist()
local tasklist_buttons = theme.tasklist()

-- Keyboard map indicator and switcher
local keyboardlayout = awful.widget.keyboardlayout()
-- Textclock widget
local textclock = wibox.widget{
  	format = "%H:%M:%S",
        align = 'center',
        valign = 'center',
        widget = wibox.widget.textclock
} 
-- Date widget
local date = wibox.widget{
	format = "%A %B %d, %Y",
	align = 'center',
	valign = 'center',
	widget = wibox.widget.textclock
}

awful.screen.connect_for_each_screen(function(s)
	-- Create a promptbox for each screen
	s.promptbox = awful.widget.prompt()

	-- Create an imagebox widget which will contain an icon indicating which layout we're using.
	-- We need one layoutbox per screen.
	s.layoutbox = awful.widget.layoutbox(s)
	s.layoutbox:buttons(gears.table.join(
		-- LMB: 		Cycle next layout
		awful.button({ }, 1, function () awful.layout.inc( 1) end),
		-- RMB: 		Cycle previous layout
		awful.button({ }, 3, function () awful.layout.inc(-1) end),
		-- Scrollup: 		Cycle next layout
		awful.button({ }, 4, function () awful.layout.inc( 1) end),
		-- Scrolldown: 		Cycle previous layout
		awful.button({ }, 5, function () awful.layout.inc(-1) end))
	)

	-- Create a taglist widget
	s.taglist = awful.widget.taglist {
		screen = s,
		filter = awful.widget.taglist.filter.all,
		buttons = taglist_buttons
	}

	-- Create a tasklist widget
	s.tasklist = awful.widget.tasklist {
		screen = s,
		filter = awful.widget.tasklist.filter.currenttags,
		buttons = tasklist_buttons
	}

	-- Create the statusbar
	s.statusbar = awful.wibar({
		screen = s,
		position = "bottom",
		height = beautiful.wibar_height,
		width = s.geometry.width - (2 * beautiful.wibar_x_padding),
		border_width = 3,
		border_color = beautiful.border_focus,
		bg = beautiful.wibar_bg,
	})

	-- Add widgets to the wibox
	s.statusbar:setup {
		layout = wibox.layout.align.horizontal,
		{ -- Left widgets
			layout = wibox.layout.fixed.horizontal,
			RC.launcher,
			s.taglist,
			s.promptbox,
		},
		{ -- Middle widgets
			layout = wibox.layout.stack,
			s.tasklist,
		},
		{ -- Right widgets
			layout = wibox.layout.fixed.horizontal,
			keyboardlayout,
			wibox.widget.systray(),
			date,
			textclock,
			s.layoutbox,
		},
	}
end)
