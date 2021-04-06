local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = require("beautiful.xresources").apply_dpi

-- Global default list of layouts
awful.layout.layouts = {
	awful.layout.suit.floating,
	awful.layout.suit.tile,
	awful.layout.suit.tile.bottom,
	awful.layout.suit.spiral.dwindle,
}

-- TODO
-- widget for layout switcher
-- awful.widget.layoutlist
-- awful.popup
