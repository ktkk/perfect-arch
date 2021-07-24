-- menu.lua
-- Awesome menu
local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup").widget
local beautiful = require("beautiful") -- Theme handling library

local menu = {}
local module = {}

local apps = RC.vars.apps

-- Menu awesome category
menu.awesome = {
	-- Show hotkey window
	{ "hotkeys",
	function()
		hotkeys_popup.show_help(nil, awful.screen.focused())
	end
	},
	-- Open config in editor
	{ "edit config", RC.vars.apps.terminal .. " -e " .. RC.vars.apps.editor .. " " .. awesome.conffile },
	-- Restart Awesome
	{ "restart", awesome.restart },
	-- Quit Awesome
	{ "quit",
		function()
			awesome.quit()
		end
	},
}

-- Menu favorites category
menu.favorites = {
	{ "Terminal", apps.terminal },
	{ "File Manager", apps.filemanager },
	{ "Browser", apps.browser },
	{ "Discord", apps.discord }
}

function module.get()
	-- Main menu
	local menu_items = {
		{ "Awesome", menu.awesome, beautiful.awesome_icon },
		{ "Favorites", menu.favorites },
		{ "Shut down", 'shutdown now' }
	}

	return menu_items
end

return setmetatable({}, { __call = function(_, ...) return module.get(...) end })
