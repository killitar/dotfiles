local M = {}

function M.get(colors, separator, icons)
	local conditions = require("heirline.conditions")
	local Align = { provider = "%=" }
	local Space = { provider = " " }

	local Mode = require("plugins.ui.heirline_config.components.ViMode").get(colors, separator)
	local FileNameBlock = require("plugins.ui.heirline_config.components.FileName").get(colors, separator)
	local FileType = require("plugins.ui.heirline_config.components.FileType").get(colors, separator)
	local Git = require("plugins.ui.heirline_config.components.Git").get(colors, separator, icons)
	local Ruler = require("plugins.ui.heirline_config.components.Ruler").get(colors, separator)
	local Diagnostics = require("plugins.ui.heirline_config.components.Diagnostics").get(colors, separator, icons)
	local LSPActive = require("plugins.ui.heirline_config.components.LSPActive").get(colors, separator)

	local LazyUpdates = require("plugins.ui.heirline_config.components.LazyUpdates").get(colors, separator)
	local LazyStats = require("plugins.ui.heirline_config.components.LazyStats").get(colors, separator)

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
				provider = "ЁЯТд lazy ",
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

	return StatusLines
end

return M
