local present1, lspconfig = pcall(require, "lspconfig")
local present2, lspinstall = pcall(require, "nvim-lsp-installer")
local present3, lspsignature = pcall(require, "lsp_signature")
if not (present1 or present2 or present3) then
	return
end

lspinstall.on_server_ready(function(server)
	local opts = {}

	-- (optional) Customize the options passed to the server
	-- if server.name == "tsserver" then
	-- 	opt.root_dir = function() ... end
	-- end

	server:setup(opts)
	vim.cmd("do User LspAttachBuffers")
end)

lspsignature.setup()
