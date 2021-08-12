-- theme.lua
-- Dark theme file
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local xrdb = xresources.get_current_theme()

local gears = require("gears")

-- Icons
local icon_path = gears.filesystem.get_configuration_dir() .. "theme/dark/"

-- TODO: write a function that sets the svg colors according to the theme colors

-- Inherit from the default theme
local themes_path = gears.filesystem.get_themes_dir()
local theme = {}

-- Variables
-- Query xresources
local colors = {
	xbackground = xrdb.background or "#222222",
	xforeground = xrdb.foreground or "#dfdfdf",
	xblack = { light = xrdb.color0 or "#2c2c2", dark = xrdb.color8 or "#404040" },
	xred = { light = xrdb.color1 or "#c44b44", dark = xrdb.color9 or "#bf615e" },
	xgreen = { light = xrdb.color2 or "#758c5a", dark = xrdb.color10 or "#74b74" },
	xyellow = { light = xrdb.color3 or "#d3904d", dark = xrdb.color11 or "#d6aa58" },
	xblue = { light = xrdb.color4 or "#3a5fa9", dark = xrdb.color12 or "#6781b6" },
	xmagenta = { light = xrdb.color5 or "#935b9c", dark = xrdb.color13 or "#cfa1d2" },
	xcyan = { light = xrdb.color6 or "#296b72", dark = xrdb.color14 or "#6cbac3" },
	xwhite = { light = xrdb.color7 or "#dddddd", dark = xrdb.color15 or "#ffffff" },
}

-- Font
theme.font_name 	= "Fira Code"
theme.font_size 	= "11"
theme.font 		= theme.font_name .. theme.font_size

-- BG colors
theme.bg_normal 	= colors.xbackground
theme.bg_focus 		= colors.xblack.light
theme.bg_urgent 	= colors.xyellow.dark
theme.bg_minimize 	= colors.xbackground
theme.bg_systray 	= theme.bg_normal

-- FG colors
theme.fg_normal 	= colors.xwhite.light
theme.fg_focus 		= colors.xforeground
theme.fg_urgent 	= colors.xyellow.light
theme.fg_minimize 	= colors.xforeground

-- Gaps
theme.useless_gap 	= dpi(5)

-- Borders
theme.border_width 	= dpi(3)
theme.border_radius 	= dpi(8)
theme.border_normal 	= colors.xbackground
theme.border_focus 	= colors.xblack.light
theme.border_marked 	= colors.xyellow.dark

local rounded_rect = function(radius)
	return function(cr, width, height)
		gears.shape.rounded_rect(cr, width, height, radius)
	end
end

function enable_rounding()
	if theme.border_radius and theme.border_radius > 0 then
		client.connect_signal("manage", function(c, startup)
			if not c.fullscreen and not c.maximized then
				c.shape = rounded_rect(theme.border_radius)
			end
		end)

		local function no_round_corners(c)
			if c.fullscreen or c.maximized then
				c.shape = gears.shape.rectangle
			else
				c.shape = rounded_rect(theme.border_radius)
			end
		end

		client.connect_signal("property:fullscreen", no_round_corners)
		client.connect_signal("property:maximized", no_round_corners)

	end
end

enable_rounding()

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
-- Example:
--theme.taglist_bg_focus = "#ff0000"
theme.hotkeys_bg = colors.xbackground
theme.hotkeys_fg = colors.xforeground
theme.hotkeys_modifiers_fg = colors.xwhite.light
theme.hotkeys_shape = gears.shape.rounded_rect

-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_height = dpi(15)
theme.menu_width  = dpi(100)

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Task list
theme.tasklist_plain_task_name = true
theme.tasklist_bg_normal = colors.xblack.light
theme.tasklist_bg_focus = colors.xblack.dark

-- Tag list
theme.taglist_dots_client = colors.xforeground
theme.taglist_dots_no_client = colors.xblack.dark
theme.taglist_focus = colors.xyellow.light
theme.taglist_hover = colors.xblack.dark
theme.taglist_disable_icon = true

-- Statusbar
theme.wibar_x_padding = dpi(12)
theme.volume_indicator_bar_left = colors.xyellow.light
theme.volume_indicator_bar_right = colors.xyellow.dark

-- Bling
theme.task_preview_widget_border_radius = dpi(8)
theme.task_preview_widget_bg = theme.bg_normal
theme.task_preview_widget_border_color = theme.border_focus
theme.task_preview_widget_border_width = theme.border_width
theme.task_preview_widget_margin = 3

theme.tag_preview_widget_border_radius = dpi(8)
theme.tag_preview_client_border_radius = dpi(8)
theme.tag_preview_client_opacity = 1
theme.tag_preview_client_border_color = theme.border_focus
theme.tag_preview_client_border_width = theme.border_width
theme.tag_preview_widget_border_color = theme.border_focus
theme.tag_preview_widget_border_width = theme.border_width
theme.tag_preview_widget_margin = dpi(6)

-- Define the image to load
theme.titlebar_close_button_normal = icon_path .. "titlebar/close_normal.svg"
theme.titlebar_close_button_focus  = icon_path .. "titlebar/close_focus.svg"

theme.titlebar_minimize_button_normal = icon_path .. "titlebar/minimize_normal.svg"
theme.titlebar_minimize_button_focus  = icon_path .. "titlebar/minimize_focus.svg"

theme.titlebar_ontop_button_normal_inactive = icon_path .. "titlebar/ontop_normal_inactive.svg"
theme.titlebar_ontop_button_focus_inactive  = icon_path .. "titlebar/ontop_focus_inactive.svg"
theme.titlebar_ontop_button_normal_active = icon_path .. "titlebar/ontop_normal_active.svg"
theme.titlebar_ontop_button_focus_active  = icon_path .. "titlebar/ontop_focus_active.svg"

theme.titlebar_sticky_button_normal_inactive = icon_path .. "titlebar/sticky_normal_inactive.svg"
theme.titlebar_sticky_button_focus_inactive  = icon_path .. "titlebar/sticky_focus_inactive.svg"
theme.titlebar_sticky_button_normal_active = icon_path .. "titlebar/sticky_normal_active.svg"
theme.titlebar_sticky_button_focus_active  = icon_path .. "titlebar/sticky_focus_active.svg"

theme.titlebar_floating_button_normal_inactive = icon_path .. "titlebar/floating_normal_inactive.svg"
theme.titlebar_floating_button_focus_inactive  = icon_path .. "titlebar/floating_focus_inactive.svg"
theme.titlebar_floating_button_normal_active = icon_path .. "titlebar/floating_normal_active.svg"
theme.titlebar_floating_button_focus_active  = icon_path .. "titlebar/floating_focus_active.svg"

theme.titlebar_maximized_button_normal_inactive = icon_path .. "titlebar/maximized_normal_inactive.svg"
theme.titlebar_maximized_button_focus_inactive  = icon_path .. "titlebar/maximized_focus_inactive.svg"
theme.titlebar_maximized_button_normal_active = icon_path .. "titlebar/maximized_normal_active.svg"
theme.titlebar_maximized_button_focus_active  = icon_path .. "titlebar/maximized_focus_active.svg"

-- You can use your own layout icons like this:
theme.layout_fairh = icon_path .. "layouts/fairhw.png"
theme.layout_fairv = icon_path .. "layouts/fairvw.png"
theme.layout_floating  = icon_path .. "layouts/floatingw.png"
theme.layout_magnifier = icon_path .. "layouts/magnifierw.png"
theme.layout_max = icon_path .. "layouts/maxw.png"
theme.layout_fullscreen = icon_path .. "layouts/fullscreenw.png"
theme.layout_tilebottom = icon_path .. "layouts/tilebottomw.png"
theme.layout_tileleft   = icon_path .. "layouts/tileleftw.png"
theme.layout_tile = icon_path .. "layouts/tilew.png"
theme.layout_tiletop = icon_path .. "layouts/tiletopw.png"
theme.layout_spiral  = icon_path .. "layouts/spiralw.png"
theme.layout_dwindle = icon_path .. "layouts/dwindlew.png"
theme.layout_cornernw = icon_path .. "layouts/cornernww.png"
theme.layout_cornerne = icon_path .. "layouts/cornernew.png"
theme.layout_cornersw = icon_path .. "layouts/cornersww.png"
theme.layout_cornerse = icon_path .. "layouts/cornersew.png"

theme.distro_icon = icon_path .. "distro/arch.svg"

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = Adwaita

return theme
