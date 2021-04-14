-- globalkeys.lua
-- Global keybinds
local gears = require("gears")
local awful = require("awful")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")

-- Modifiers
local keys = rc.vars.keys

local M = {}

-- Global keybinds
function M.get()
	local globalkeys = gears.table.join(
		-- Formatting
		-- awful.key({ MODIFIER KEYS }, KEY, FUNCTION, {description = DESCRIPTION, group = GROUP}),
		-- Description and group are displayed in the help menu

		-------------------------------------------------------------------------------------------
		-- General
		-- Super - S: 		Help menu
		awful.key({ keys.modkey, }, "s", hotkeys_popup.show_help, {description = "show help", group = "awesome"}),
		-- Super - Ctrl - R:	Reload Awesome
		awful.key({ keys.modkey, keys.ctrl }, "r", awesome.restart, {description = "reload awesome", group = "awesome"}),
		-- Super - Shift - Q:	Quit Awesome
		awful.key({ keys.modkey, keys.shift }, "q", awesome.quit, {description = "quit awesome", group = "awesome"}),

		-- Tags
		-- Super - Left:	Cycle tags left
		awful.key({ keys.modkey, }, "Left", awful.tag.viewprev, {description = "view previous", group = "tag"}),
		-- Super - Right:	Cycle tags right
		awful.key({ keys.modkey, }, "Right", awful.tag.viewnext, {description = "view next", group = "tag"}),
		-- Super - Esc:		Go to previously visited tag
		awful.key({ keys.modkey, }, keys.escape, awful.tag.history.restore, {description = "go back", group = "tag"}),

		-------------------------------------------------------------------------------------------
		-- Clients
		-- Super - J:		Cycle clients left
		awful.key({ keys.modkey, }, "j",
				function ()
				    awful.client.focus.byidx( 1)
				end,
			{description = "focus next by index", group = "client"}),
		-- Super - K:		Cycle clients right
		awful.key({ keys.modkey, }, "k",
				function ()
				    awful.client.focus.byidx(-1)
				end,
			{description = "focus previous by index", group = "client"}),
		-- Super - Shift - Tab:	Cycle 2 most recent clients
		awful.key({ keys.modkey, keys.shift }, keys.tab,
				function ()
				    awful.client.focus.history.previous()
				    if client.focus then
					client.focus:raise()
				    end
				end,
			{description = "go back", group = "client"}),
		-- Super - U:		Jump to urgent client
		awful.key({ keys.modkey, }, "u", awful.client.urgent.jumpto, {description = "jump to urgent client", group = "client"}),
		-- Super - Ctrl - N:	Restore minimized client
		awful.key({ keys.modkey, keys.ctrl }, "n",
				function ()
					local c = awful.client.restore()
					-- Focus restored client
					if c then
						c:emit_signal(
						"request::activate", "key.unminimize", {raise = true}
						)
					end
				end,
			{description = "restore minimized", group = "client"}),

		-------------------------------------------------------------------------------------------
		-- Menu
		-- Super - W:		Show main menu
		awful.key({ keys.modkey, }, "w",
				function ()
					mymainmenu:show()
				end,
			{description = "show main menu", group = "awesome"}),

		-------------------------------------------------------------------------------------------
		-- Layout manipulation
		-- Super - Shift - J:	Swap clients left
		awful.key({ keys.modkey, keys.shift }, "j",
				function ()
					awful.client.swap.byidx(1)
				end,
			{description = "swap with next client by index", group = "client"}),
		-- Super - Shift - K:	Swap clients right
		awful.key({ keys.modkey, keys.shift }, "k",
				function ()
					awful.client.swap.byidx(-1)
				end,
			{description = "swap with previous client by index", group = "client"}),
		-- Super - Ctrl - J:	Focus screen left
		awful.key({ keys.modkey, keys.ctrl }, "j",
				function ()
					awful.screen.focus_relative(1)
				end,
			{description = "focus the next screen", group = "screen"}),
		-- Super - Ctrl - K:	Focus screen right
		awful.key({ keys.modkey, keys.ctrl }, "k",
				function ()
					awful.screen.focus_relative(-1)
				end,
			{description = "focus the previous screen", group = "screen"}),
		-- Super - L:		Increase master client width
		awful.key({ keys.modkey, }, "l",
				function ()
					awful.tag.incmwfact(0.05)
				end,
			{description = "increase master width factor", group = "layout"}),
		-- Super - H:		Decrease master client width
		awful.key({ keys.modkey, }, "h",
				function ()
					awful.tag.incmwfact(-0.05)
				end,
			{description = "decrease master width factor", group = "layout"}),
		-- Super - Shift - H:	Increase nr of master clients
		awful.key({ keys.modkey, keys.shift }, "h",
				function ()
					awful.tag.incnmaster(1, nil, true)
				end,
			{description = "increase the number of master clients", group = "layout"}),
		-- Super - Shift - L:	Decrease nr of master clients
		awful.key({ keys.modkey, keys.shift }, "l",
				function ()
					awful.tag.incnmaster(-1, nil, true)
				end,
			{description = "decrease the number of master clients", group = "layout"}),
		-- Super - Ctrl - H:	Increase nr of columns
		awful.key({ keys.modkey, keys.ctrl }, "h",
				function ()
					awful.tag.incncol(1, nil, true)
				end,
			{description = "increase the number of columns", group = "layout"}),
		-- Super - Ctrl - L:	Decrease nr of columns
		awful.key({ keys.modkey, keys.ctrl }, "l",
				function ()
					awful.tag.incncol(-1, nil, true)
				end,
			{description = "decrease the number of columns", group = "layout"}),
		-- Super - Space:	Switch to next layout
		awful.key({ keys.modkey, }, keys.space,
				function ()
					awful.layout.inc( 1)
				end,
			{description = "select next", group = "layout"}),
		-- Super - Shift - Space:	Switch to previous layout
		awful.key({ keys.modkey, keys.shift }, keys.space,
				function ()
					awful.layout.inc(-1)
				end,
			{description = "select previous", group = "layout"}),

		-------------------------------------------------------------------------------------------
		-- Program launch keybind
		-- Super - Enter:	Spawn terminal
		awful.key({ keys.modkey, }, keys.enter,
				function ()
					awful.spawn(apps.terminal)
				end,
			  {description = "open a terminal", group = "launcher"}),

		-------------------------------------------------------------------------------------------
		-- Run prompt
		-- Super - R:		Run prompt
		awful.key({ keys.modkey }, "r",
				function ()
					awful.screen.focused().mypromptbox:run()
				end,
			  {description = "run prompt", group = "launcher"}),
		-- Super - X:		Lua run prompt
		awful.key({ keys.modkey }, "x",
				function ()
					  awful.prompt.run {
						  prompt       = "Run Lua code: ",
						  textbox      = awful.screen.focused().mypromptbox.widget,
						  exe_callback = awful.util.eval,
						  history_path = awful.util.get_cache_dir() .. "/history_eval"
					  }
				end,
			  {description = "lua execute prompt", group = "awesome"}),

		-------------------------------------------------------------------------------------------
		-- Menubar
		awful.key({ keys.modkey }, "p",
				function()
					menubar.show()
				end,
			  {description = "show the menubar", group = "launcher"})
	)

	return globalkeys
end

return setmetatable({}, { __call = function(_, ...) return M.get(...) end })
