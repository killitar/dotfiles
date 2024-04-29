return {
	"craftzdog/solarized-osaka.nvim",
	priority = 1000,
	opts = {
		transparent = true,
		styles = {
			floats = "transparent",
		},
		on_highlights = function(hl, c)
			hl.LazyNormal = { bg = c.bg }
			hl.MasonNormal = { bg = c.bg }
			hl.TroubleNormal = { bg = c.bg }
			-- hl.MiniCursorword = { bg = c.violet900 }
			-- hl.MiniCursorwordCurrent = { bg = c.violet900 }
			-- hl.Visual = { bg = c.base02, reverse = false }
		end,
	},
}
