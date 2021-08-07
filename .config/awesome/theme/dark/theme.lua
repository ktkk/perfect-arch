-- theme.lua
-- Dark theme file
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local xrdb = xresources.get_current_theme()

local gears = require("gears")

-- Inherit from the default theme
local themes_path = gears.filesystem.get_themes_dir()

local theme = dofile(themes_path .. "default/theme.lua")
local theme_assets = require("beautiful.theme_assets")

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
theme.font_name 	= "FiraCode"
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

-- Generate taglist squares:
local taglist_square_size = dpi(4)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
    taglist_square_size, theme.fg_normal
)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
    taglist_square_size, theme.fg_normal
)

-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = themes_path.."default/submenu.png"
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

-- Statusbar
theme.wibar_x_padding = dpi(12)

-- Define the image to load
theme.titlebar_close_button_normal = themes_path.."default/titlebar/close_normal.png"
theme.titlebar_close_button_focus  = themes_path.."default/titlebar/close_focus.png"

theme.titlebar_minimize_button_normal = themes_path.."default/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus  = themes_path.."default/titlebar/minimize_focus.png"

theme.titlebar_ontop_button_normal_inactive = themes_path.."default/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = themes_path.."default/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = themes_path.."default/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = themes_path.."default/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = themes_path.."default/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = themes_path.."default/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = themes_path.."default/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = themes_path.."default/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = themes_path.."default/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = themes_path.."default/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = themes_path.."default/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = themes_path.."default/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = themes_path.."default/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = themes_path.."default/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = themes_path.."default/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active  = themes_path.."default/titlebar/maximized_focus_active.png"

theme.wallpaper = themes_path.."default/background.png"

-- You can use your own layout icons like this:
theme.layout_fairh = themes_path.."default/layouts/fairhw.png"
theme.layout_fairv = themes_path.."default/layouts/fairvw.png"
theme.layout_floating  = themes_path.."default/layouts/floatingw.png"
theme.layout_magnifier = themes_path.."default/layouts/magnifierw.png"
theme.layout_max = themes_path.."default/layouts/maxw.png"
theme.layout_fullscreen = themes_path.."default/layouts/fullscreenw.png"
theme.layout_tilebottom = themes_path.."default/layouts/tilebottomw.png"
theme.layout_tileleft   = themes_path.."default/layouts/tileleftw.png"
theme.layout_tile = themes_path.."default/layouts/tilew.png"
theme.layout_tiletop = themes_path.."default/layouts/tiletopw.png"
theme.layout_spiral  = themes_path.."default/layouts/spiralw.png"
theme.layout_dwindle = themes_path.."default/layouts/dwindlew.png"
theme.layout_cornernw = themes_path.."default/layouts/cornernww.png"
theme.layout_cornerne = themes_path.."default/layouts/cornernew.png"
theme.layout_cornersw = themes_path.."default/layouts/cornersww.png"
theme.layout_cornerse = themes_path.."default/layouts/cornersew.png"

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(
    theme.menu_height, theme.bg_focus, theme.fg_focus
)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

return theme
