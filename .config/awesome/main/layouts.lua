-- layouts.lua
-- Layouts
local awful = require("awful")

local module = {}

function module.get()
	local layouts = {
		-- Floating layout
		awful.layout.suit.floating,
		-- Tile right
		awful.layout.suit.tile,
		-- Tile bottom
		awful.layout.suit.tile.bottom,
		-- Fibonacci dwindle
		awful.layout.suit.spiral.dwindle
	}

	return layouts
end

return setmetatable({}, { __call = function(_, ...) return module.get(...) end })
