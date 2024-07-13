return {
	"cdmill/neomodern.nvim",
	priority = 1000,
	opts = {
		ui = {
			cmp_itemkind_reverse = false,
			telescope = "bordered",
			transparent = false,
		},
		highlights = {
			FloatBorder = { bg = "visual" },
			FloatTitle = { bg = "bg" },
			MiniFilesBorder = { bg = "visual" },
			-- MiniFilesTitle = { bg = "bg", fg = "bg" },
			MiniFilesNormal = { bg = "bg" },
			IndentBlanklineContextChar = { fg = "visual" },
		},
	},
}
