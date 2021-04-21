-- globalmouse.lua
-- Global mousebinds
local gears = require("gears")
local awful = require("awful")

local module = {}

function module.get()
	local globalmouse = gears.table.join(
		-- RMB: 		Toggle main menu
		awful.button({ }, 3, function () RC.mainmenu:toggle() end),
		-- Scroll up: 		Go to next tag
		awful.button({ }, 4, awful.tag.viewnext),
		-- Scroll down: 	Go to previous tag
		awful.button({ }, 5, awful.tag.viewprev)
	)

	return globalmouse
end

return setmetatable({}, { __call = function(_, ...) return module.get(...) end })
