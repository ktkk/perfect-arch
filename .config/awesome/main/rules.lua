-- rules.lua
-- Rules
local awful = require("awful")
local beautiful = require("beautiful")

local module = {}

function module.get(clientkeys, clientbuttons)
	local rules = {
		-- All clients will match this rule
		{ rule = {},
			properties = {
				border_width = beautiful.border_width,
				border_color = beautiful.border_normal,
				focus = awful.client.focus.filter,
				raise = true,
				keys = clientkeys,
				buttons = clientbuttons,
				screen = awful.screen.preferred,
				placement = awful.placement.no_overlap+awful.placement.no_offscreen,
			}
		},

		-- Floating clients
		{ rule_any = {
			instance = {
				-- Application instances
			},

			class = {
				-- Application classes
			},

			name = {
				-- Application names
			},

			role = {
				-- Application roles
			}
		},

			-- Set the property
			properties = { floating = true }
		},

		-- Add titlebars to normal clients and dialogs
		{ rule_any = { type = { "normal", "dialog" }
			},

			properties = { titlebars_enabled = true }
		},

		-- Set Firefox to always map on the tag named "2" on screen 1.
		-- { rule = { class = "Firefox" },
		--
		-- 	properties = { screen = 1, tag = "2" }
		-- },
	}

	return rules
end

return setmetatable({}, { __call = function(_, ...) return module.get(...) end })
