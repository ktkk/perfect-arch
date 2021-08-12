-- RC.LUA
-- Main config file

-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")
require("awful.autofocus")

-- Standard awesome libraries
local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful") -- Theme handling library
local menubar = require("menubar")

-- global namespace
RC = {}
RC.vars = require("vars")

-- Autostart
-- Handled by .config/x11/xprofile

-- Error Handling
require("error-handling")

-- Theme
-- beautiful.init(gears.filesystem.get_themes_dir() .. "xresources/theme.lua")
beautiful.init(gears.filesystem.get_configuration_dir() .. "theme/" .. RC.vars.theme .. "/theme.lua")

-- Bling
local bling = require("bling")

bling.widget.tag_preview.enable {
	show_client_content = true,
	x = 10,
	y = 10,
	scale = 0.15,
	honor_padding = true,
	honor_workarea = true,
	placement_fn = function(c)
		awful.placement.bottom_left(c, { margins = { bottom = 40, left = 8 } })
	end,
}

bling.widget.task_preview.enable {
	x = 10,
	y = 10,
	placement_fn = function(c)
		awful.placement.bottom(c, { margins = { bottom = 40 } })
	end,
	widget_structure = {
		{
			{
				{
					id = "icon_role", -- The client icon
					widget = awful.widget.clienticon,
				},
				{
					id = "name_role", -- The client name
					widget = wibox.widget.textbox,
				},
				layout = wibox.layout.flex.horizontal,
			},
			widget = wibox.container.margin,
			margins = 5,
		},
		{
			id = "image_role", -- The client preview image
			resize = true,
			valign = "center",
			halign = "center",
			widget = wibox.widget.imagebox,
		},
		layout = wibox.layout.fixed.vertical,
	},
}

-- Main
local main = {
	menu 		= require("main.menu"),
	layouts 	= require("main.layouts"),
	tags 		= require("main.tags"),
	rules 		= require("main.rules"),
	signals 	= require("main.signals")
}

-- Keys
local keys = {
	globalkeys 	= require("keys.globalkeys"),
	globalmouse 	= require("keys.globalmouse"),
	clientkeys 	= require("keys.clientkeys"),
	clientmouse 	= require("keys.clientmouse"),
	bindtotags 	= require("keys.bindtotags")
}

-- Layouts
RC.layouts = main.layouts()
awful.layout.layouts = RC.layouts

-- Tags
RC.tags = main.tags()

-- Menu
RC.mainmenu = awful.menu({ items = main.menu() })

-- Mouse and Key bindings
RC.globalkeys = keys.globalkeys()
RC.globalkeys = keys.bindtotags(RC.globalkeys)

root.buttons(keys.globalmouse())
root.keys(RC.globalkeys)

-- Popups
--

-- Widgets
local widgets = {
	statusbar 	= require("theme.statusbar")
}

-- Statusbar
RC.statusbar = widgets.statusbar

-- Rules
awful.rules.rules = main.rules(
	keys.clientkeys(),
	keys.clientmouse()
)

-- Signals
RC.signals = main.signals
