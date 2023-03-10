local status, devIcons = pcall(require, "nvim-web-devicons")
if not status then
	return
end

devIcons.setup({
	override = {},
	default = true,
})
