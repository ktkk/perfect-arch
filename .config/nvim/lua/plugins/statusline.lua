local present1, gl = pcall(require, "galaxyline")
local present2, condition = pcall(require, "galaxyline.condition")
if not (present1 or present2) then
	return
end

local gls = gl.selection

gl.short_line_list = { " " }


