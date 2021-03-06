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

local utils = RC.utils

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
			widget = wibox.widget.systray,
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

hovering_volume = false
local function update_volume()
	local volume = utils.get_volume()
	local muted = utils.get_muted()

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

-- gears.timer {
-- 	timeout = 5,
-- 	call_now = true,
-- 	autostart = true,
-- 	callback = function() update_volume() end,
-- }

-- ]]

-- [[ Launcher
local launcher = {
	{
		{
			widget = awful.widget.launcher({ image = beautiful.distro_icon, menu = RC.mainmenu }),
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

	-- Taglist
	local function update_taglist(self, t, index, tags)
		local has_client = false
		local has_focus = false

		for _, c in ipairs(client.get()) do
			if t == c.first_tag then
				has_client = true
				break
			end
		end
		for _, tag in ipairs(awful.screen.focused().selected_tags) do
			if t == tag then
				has_focus = true
			end
		end

		if has_focus then
			self:get_children_by_id("index_role")[1].markup = "<b> " .. '' .. " </b>"
			self.fg = beautiful.taglist_focus
		else
			self:get_children_by_id("index_role")[1].markup = "<b> " .. '' .. " </b>"
			self.fg = beautiful.taglist_dots_client
		end
		if not has_focus and not has_client then
			self.fg = beautiful.taglist_dots_no_client
		end
	end

	local taglist_widget = awful.widget.taglist {
		screen = s,
		filter = awful.widget.taglist.filter.all,
		widget_template = {
			{
				{
					{
						{
							{
								id = "index_role",
								widget = wibox.widget.textbox,
							},
							widget = wibox.container.margin,
						},
						shape = gears.shape.circle,
						widget = wibox.widget.background,
					},
					{
						{
							id = "icon_role",
							widget = wibox.widget.imagebox,
						},
						widget = wibox.container.margin,
					},
					layout = wibox.layout.fixed.horizontal,
				},
				left = 1,
				right = 1,
				widget = wibox.container.margin,
			},
			id = "background_role",
			widget = wibox.container.background,
			create_callback = function(self, t, index, tags)
				update_taglist(self, t, index, tags)

				self:connect_signal("mouse::enter", function()
					if self.bg ~= beautiful.taglist_hover then
						self.backup = self.bg
						self.has_backup = true
					end
					self.bg = beautiful.taglist_hover

					if #t:clients() > 0 then
						awesome.emit_signal("bling::tag_preview::update", t)
						awesome.emit_signal("bling::tag_preview::visibility", s, true)
					end
				end)
				self:connect_signal("mouse::leave", function()
					if self.has_backup then self.bg = self.backup end

					awesome.emit_signal("bling::tag_preview::visibility", s, false)
				end)
			end,
			update_callback = function(self, t, index, tags)
				update_taglist(self, t, index, tags)
			end,
		},
		buttons = taglist_buttons,
	}

	s.taglist = wibox.widget {
		{
			widget = taglist_widget,
		},
		shape = gears.shape.rounded_rect,
		shape_clip = true,
		widget = wibox.container.background,
		bg = beautiful.bg_focus,
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
			max_widget_size = 300,
			layout = wibox.layout.flex.horizontal,
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
			create_callback = function(self, c, index, objects)
				self:connect_signal("mouse::enter",
					function()
						awesome.emit_signal("bling::task_preview::visibility", s, true, c)
					end)
				self:connect_signal("mouse::leave",
					function()
						awesome.emit_signal("bling::task_preview::visibility", s, false, c)
					end)
				end,
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
