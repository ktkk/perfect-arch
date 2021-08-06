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

-- Textclock widget
local textclock = wibox.widget{
	{
		{
			{
				id = "clock",
				refresh = 1,
				format = "%H:%M:%S",
				widget = wibox.widget.textclock
			},
			widget = wibox.container.margin,
			left = 12,
			right = 12,
		},
		widget = wibox.container.background,
		shape = gears.shape.rounded_bar,
		bg = beautiful.bg_focus,
	},
	widget = wibox.container.margin,
	top = 1,
	bottom = 1,
}
textclock:connect_signal("mouse::enter",
	function()
		textclock:get_children_by_id("clock")[1].format = "%a %d %b, %H:%M:%S"
	end
)
textclock:connect_signal("mouse::leave",
	function()
		textclock:get_children_by_id("clock")[1].format = "%H:%M:%S"
	end
)

-- Systray
local systray = {
	{
		{
			widget = wibox.widget.systray(),
			id = "systray"
		},
		widget = wibox.container.margin,
		top = 3,
		bottom = 3,
		left = 3,
		right = 3
	},
	widget = wibox.container.background,
	shape = gears.shape.rounded_bar,
	bg = beautiful.bg_focus,
}

local volumebar = wibox.widget{
	widget = wibox.container.margin,
	top = 1,
	bottom = 1,
}

-- Launcher
local launcher = {
	{
		{
			widget = awful.widget.launcher({ image = beautiful.awesome_icon, menu = RC.mainmenu }),
		},
		widget = wibox.container.margin,
		top = 3,
		bottom = 3,
		left = 3,
		right = 3,

	},
	widget = wibox.container.background,
	shape = gears.shape.rounded_bar,
	bg = beautiful.bg_focus,
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
		height = 36,
		bg = beautiful.wibar_bg,
	})

	-- Add widgets to the wibox
	s.statusbar:setup {
		{
			{
				layout = wibox.layout.align.horizontal,
				expand = "none",
				{ -- Left widgets
					layout = wibox.layout.fixed.horizontal,
					launcher,
					s.taglist,
					s.promptbox,
				},
				{ -- Middle widgets
					layout = wibox.layout.stack,
					s.tasklist,
				},
				{ -- Right widgets
					layout = wibox.layout.fixed.horizontal,
					systray,
					-- wibox.widget.systray(),
					volumebar,
					textclock,
					s.layoutbox,
				},
			},
			bottom = 4,
			top = 4,
			left = 4,
			right = 4,
			color = beautiful.bg_normal,
			widget = wibox.container.margin,
		},
		top = 3,
		color = beautiful.border_focus,
		widget = wibox.container.margin,
	}
end)
