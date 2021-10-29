local present, formatter = pcall(require, "formatter")
if not present then
	return
end

formatter.setup({
filetype = {
	cpp = {
		function()
			return {
				exe = "clang-format",
				args = { "--assume-filename", vim.api.nvim_buf_get_name(0) },
				stdin = true,
				cwd = vim.fn.expand('%:p:h')
			}
		end
	},
}
})
