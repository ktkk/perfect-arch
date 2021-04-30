-- RC.LUA
-- Main config file

-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome libraries
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
local wibox = require("wibox") -- Widget and layout library
local beautiful = require("beautiful") -- Theme handling library
local naughty = require("naughty") -- Notification library
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

-- global namespace
RC = {}
RC.vars = require("vars")

-- Autostart
-- Handled by .config/x11/xprofile

-- Error Handling
require("error-handling")

-- Theme
beautiful.init(gears.filesystem.get_configuration_dir() .. "theme/" .. RC.vars.theme .. "/theme.lua")

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
RC.launcher = awful.widget.launcher({ image = beautiful.awesome_icon, menu = RC.mainmenu })

-- Mouse and Key bindings
RC.globalkeys = keys.globalkeys()
RC.globalkeys = keys.bindtotags(RC.globalkeys)

root.buttons(keys.globalmouse())
root.keys(RC.globalkeys)

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
