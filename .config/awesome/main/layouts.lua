-- layouts.lua
-- Layouts
local awful = require("awful")

local module = {}

function module.get()
	local layouts = {
		-- Tile right
		awful.layout.suit.tile,
		-- Floating layout
		awful.layout.suit.floating,
		-- Tile bottom
		awful.layout.suit.tile.bottom,
		-- Fibonacci dwindle
		awful.layout.suit.spiral.dwindle
	}

	return layouts
end

return setmetatable({}, { __call = function(_, ...) return module.get(...) end })
