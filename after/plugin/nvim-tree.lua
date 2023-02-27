require("nvim-tree").setup({
	hijack_directories = {
		enable = false,
	},
	filters = {
		custom = { ".git" },
		exclude = { ".gitignore" },
	},
	-- auto_close = true,
	-- open_on_tab = false,
	-- hijack_cursor = false,
	update_cwd = true,
	-- update_to_buf_dir = {
	--   enable = true,
	--   auto_open = true,
	-- },
	-- --   error
	-- --   info
	-- --   question
	-- --   warning
	-- --   lightbulb
	diagnostics = {
		enable = true,
	},
	update_focused_file = {
		enable = true,
		update_cwd = true,
		ignore_list = {},
	},
	-- system_open = {
	--   cmd = nil,
	--   args = {},
	-- },
	-- filters = {
	--   dotfiles = false,
	--   custom = {},
	-- },
	git = {
		enable = true,
		ignore = true,
		timeout = 500,
	},
	view = {
		width = 30,
		hide_root_folder = false,
		side = "right",
		-- auto_resize = true,
		number = false,
		relativenumber = false,
	},
})

vim.keymap.set("n", "<leader>tr", ":NvimTreeToggle<CR>")
