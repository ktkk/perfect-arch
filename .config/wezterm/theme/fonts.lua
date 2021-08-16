local query = io.popen("xrdb -query"):read("*a")

fonts = {
	regular_font = query:match("%*font:%s*xft:(%w*%s*%w*)"),
	bold_font = query:match("%*boldFont:%s*xft:(%w*%s*%w*)"),
	italic_font = query:match("%*italicFont:%s*xft:(%w*%s*%w*)"),
	bold_italic_font = query:match("%*boldItalicFont:%s*xft:(%w*%s*%w*)"),

	size = tonumber(query:match("*font:%s*xft:%w*%s*%w*:size=(%d*)")),
}

print(fonts.size)

return fonts
