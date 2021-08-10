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

-- [[ Textclock widget
local textclock = wibox.widget{
	{
		{
			{
				{
					align = "center",
					valign = "center",
					widget = wibox.widget.textbox,
					text = " "
				},
				widget = wibox.container.margin,
				left = 10,
			},
			{
				{
					id = "clock",
					refresh = 1,
					format = "%H:%M:%S",
					widget = wibox.widget.textclock
				},
				widget = wibox.container.margin,
				right = 12,
			},
			widget = wibox.widget,
			layout = wibox.layout.fixed.horizontal,
		},
		widget = wibox.container.background,
		shape = gears.shape.rounded_rect,
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
-- ]]

-- [[ Systray
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
-- ]]

-- [[ Volume bar
local volumebar = wibox.widget{
	{
		{
			{
				{
					align = "center",
					valign = "center",
					widget = wibox.widget.textbox,
					text = "墳 "
				},
				widget = wibox.container.margin,
				left = 10,
			},
			{
				{
					{
						id = "progress_bar",
						widget = wibox.widget.progressbar,
						forced_width = 80,
						shape = gears.shape.rounded_bar,
						bar_shape = gears.shape.rounded_bar,
						background_color = beautiful.bg_focus,
					},
					{
						id = "text_box",
						align = "center",
						valign = "center",
						widget = wibox.widget.textbox,
					},
					widget = wibox.widget,
					layout = wibox.layout.stack,
				},
				widget = wibox.container.margin,
				top = 4,
				bottom = 4,
				left = 4,
				right = 4,
			},
			widget = wibox.widget,
			layout = wibox.layout.fixed.horizontal,
		},
		widget = wibox.container.background,
		shape = gears.shape.rounded_rect,
		bg = beautiful.bg_focus,
	},
	widget = wibox.container.margin,
	top = 1,
	bottom = 1,
}

local function get_volume()
	local query = io.popen("amixer sget Master"):read("*a")
	return tonumber(query:match("(%d?%d?%d)%%"))
end

local function get_muted()
	local query = io.popen("amixer sget Master"):read("*a")
	local status = query:match("%[(o[^%]]*)%]")

	if status:find("on", 1, true) then
		return false
	end
	return true
end

hovering_volume = false
function update_volume()
	local volume = get_volume()
	local muted = get_muted()

	local textbox = volumebar:get_children_by_id("text_box")[1]
	if hovering_volume then
		if muted then
			textbox.text = "muted"
		else
			textbox.text = volume .. '%'
		end
	else
		textbox.text = ''
	end

	local progressbar = volumebar:get_children_by_id("progress_bar")[1]
	progressbar:set_value(volume / 100)
	progressbar.color = {
		type = "linear",
		from = { 0, 0, 0 },
		to = { 90, 0, 0 },
		stops = { { 0, beautiful.volume_indicator_bar_left }, { volume / 100, beautiful.volume_indicator_bar_right } },
	}
end

update_volume()

awesome.connect_signal("volume_refresh", update_volume)

volumebar:connect_signal("mouse::enter", function()
	hovering_volume = true
	update_volume()
end)

volumebar:connect_signal("mouse::leave", function()
	hovering_volume = false
	update_volume()
end)

gears.timer {
	timeout = 0.1,
	call_now = true,
	autostart = true,
	callback = function() update_volume() end,
}

-- ]]

-- [[ Launcher
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
-- ]]

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
		buttons = tasklist_buttons,
		style = {
			shape = gears.shape.rounded_rect,
		},
		layout = {
			spacing = 6,
			layout = wibox.layout.fixed.horizontal,
		},
		widget_template = {
			{
				{
					{
						id = "icon_role",
						widget = wibox.widget.imagebox,
					},
					{
						forced_width = 6,
						layout = wibox.layout.fixed.horizontal,
					},
					{
						id = "text_role",
						widget = wibox.widget.textbox,
					},
					layout = wibox.layout.fixed.horizontal,
				},
				top = 3,
				bottom = 3,
				left = 10,
				right = 10,
				widget = wibox.container.margin,
			},
			id = "background_role",
			widget = wibox.container.background,
		}
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
					spacing = 8,
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
					spacing = 8,
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
