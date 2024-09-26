return {
	"rebelot/heirline.nvim",
	event = "UIEnter",
	config = function()
		local conditions = require("heirline.conditions")
		local colors = require("obscure.palettes").get_palette("obscure")
		local icons = {
			diagnostics = require("helpers.icons").get("diagnostics", true),
			git = require("helpers.icons").get("git", true),
		}

		local separator = { left = "", right = "" }
		local Align = { provider = "%=" }
		local Space = { provider = " " }

		local Mode = require("plugins.ui.heirline_components.ViMode").get(colors, separator)
		local FileNameBlock = require("plugins.ui.heirline_components.FileName").get(colors, separator)
		local FileType = require("plugins.ui.heirline_components.FileType").get(colors, separator)
		local Git = require("plugins.ui.heirline_components.Git").get(colors, separator, icons, conditions)
		local Ruler = require("plugins.ui.heirline_components.Ruler").get(colors, separator)
		local Diagnostics =
			require("plugins.ui.heirline_components.Diagnostics").get(colors, separator, icons, conditions)
		local LSPActive = require("plugins.ui.heirline_components.LSPActive").get(colors, separator, conditions)

		local LazyUpdates = require("plugins.ui.heirline_components.LazyUpdates").get(colors, separator)
		local LazyStats = require("plugins.ui.heirline_components.LazyStats").get(colors, separator)

		local DefaultStatusLine = {
			Mode,
			Space,
			Space,
			FileNameBlock,
			FileType,
			Space,
			Space,
			Git,
			Space,
			Ruler,
			Space,
			LazyUpdates,
			Align,
			Diagnostics,
			LSPActive,
			hl = { bg = colors.bg_dark },
		}

		local LazyStatusLine = {
			condition = function()
				return conditions.buffer_matches({
					filetype = { "lazy" },
				})
			end,

			{
				{
					provider = separator.left,
					hl = { fg = colors.purple, bg = colors.bg_dark },
				},
				{
					provider = "💤 lazy ",
					hl = { fg = colors.bg_dark, bg = colors.purple, bold = true },
				},
				{
					provider = separator.right,
					hl = { fg = colors.purple, bg = colors.gray2 },
				},
			},
			LazyStats,
			Space,
			LazyUpdates,
			Align,
			hl = { bg = colors.bg_dark },
		}

		local DisableStatusLine = {
			condition = function()
				return conditions.buffer_matches({
					filetype = { "dashboard", "alpha", "ministarter" },
				})
			end,
		}

		local StatusLines = {
			hl = function()
				if conditions.is_active() then
					return "StatusLine"
				else
					return "StatusLineNC"
				end
			end,

			fallthrough = false,
			LazyStatusLine,
			DisableStatusLine,
			DefaultStatusLine,
		}

		require("heirline").setup({
			statusline = StatusLines,
		})
	end,
}
