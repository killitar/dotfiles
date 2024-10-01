return {
	"rebelot/heirline.nvim",
	event = "UIEnter",
	config = function()
		local colors = require("obscure.palettes").get_palette("obscure")
		local icons = {
			diagnostics = require("helpers.icons").get("diagnostics", true),
			git = require("helpers.icons").get("git", true),
		}
		local separator = { left = "", right = "" }

		local StatusLines = require("plugins.ui.heirline_config.StatusLines").get(colors, separator, icons)

		require("heirline").setup({
			statusline = StatusLines,
		})
	end,
}
