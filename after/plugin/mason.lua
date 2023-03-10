local status, mason = pcall(require, "mason")
if not status then
	return
end
local status2, lspconfig = pcall(require, "lspconfig")
if not status2 then
    return
end
local status3, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status3 then
	return
end

mason.setup({})

mason_lspconfig.setup({
	automatic_installation = true,
    ensure_installed = {
	    "tsserver",
	    "rust_analyzer",
    },
})

mason_lspconfig.setup_handlers({
	function(server_name)
		lspconfig[server_name].setup({})
	end,

	["lua_ls"] = function()
		lspconfig.lua_ls.setup({
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
				},
			},
		})
	end,
})
