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

-- Set up completion using nvim_cmp with LSP source
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(_, bufnr)
	local opts = { buffer = bufnr, remap = false }

	vim.keymap.set("n", "gd", function()
		vim.lsp.buf.definition()
	end, opts)
	vim.keymap.set("n", "K", function()
		vim.lsp.buf.hover()
	end, opts)
	vim.keymap.set("n", "<leader>vws", function()
		vim.lsp.buf.workspace_symbol()
	end, opts)
	vim.keymap.set("n", "<leader>vd", function()
		vim.diagnostic.open_float()
	end, opts)
	vim.keymap.set("n", "[d", function()
		vim.diagnostic.goto_next()
	end, opts)
	vim.keymap.set("n", "]d", function()
		vim.diagnostic.goto_prev()
	end, opts)
	vim.keymap.set("n", "<leader>vca", function()
		vim.lsp.buf.code_action()
	end, opts)
	vim.keymap.set("n", "<leader>vrr", function()
		vim.lsp.buf.references()
	end, opts)
	vim.keymap.set("n", "<leader>vrn", function()
		vim.lsp.buf.rename()
	end, opts)
	vim.keymap.set("i", "<C-h>", function()
		vim.lsp.buf.signature_help()
	end, opts)
end

mason.setup({})

mason_lspconfig.setup({
	automatic_installation = false,
	-- ensure_installed = {
	--  "tsserver",
	--  "rust_analyzer",
	-- },
})

mason_lspconfig.setup_handlers({
	function(server_name)
		lspconfig[server_name].setup({})
	end,

	["tsserver"] = function()
		lspconfig.tsserver.setup({
			on_attach = on_attach,
			capabilities = capabilities,
			single_file_support = false,
			root_dir = lspconfig.util.root_pattern("package.json"),
			init_options = {
				lint = true,
			},
		})
	end,

	["denols"] = function()
		lspconfig.denols.setup({
			on_attach = on_attach,
			capabilities = capabilities,
			root_dir = lspconfig.util.root_pattern("deno.json"),
			init_options = {
				lint = true,
			},
		})
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

vim.diagnostic.config({
	virtual_text = true,
})
