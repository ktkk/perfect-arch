-- Global variables

local M = {
	-- Theme
	theme = "dark",

	-- Application
	apps = {
		terminal 	= os.getenv("TERMINAL") or "xterm",
		editor 		= os.getenv("EDITOR") or "vim",
		browser 	= "firefox",
		filemanager 	= "thunar",
		discord 	= "discord"
	},

	-- Keys
	keys = {
		modkey 		= "Mod4",
		alt 		= "Mod1",
		shift 		= "Shift",
		ctrl 		= "Control",
		escape 		= "Escape",
		tab 		= "Tab",
		enter 		= "Return",
		space 		= "space"
	},
}

return M
