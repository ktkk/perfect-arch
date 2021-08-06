local present, bufferline = pcall(require, "bufferline")
if not present then
	return
end

bufferline.setup {
	options = {
		offsets = {{ filetype = "NvimTree", text = "", padding = 1 }},
	}
}
