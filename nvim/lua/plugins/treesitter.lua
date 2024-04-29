return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = { "BufReadPost", "BufNewFile" },
	init = function(plugin)
		require("lazy.core.loader").add_to_rtp(plugin)
		require("nvim-treesitter.query_predicates")
	end,
	dependencies = {
		"windwp/nvim-ts-autotag",
	},
	opts = {
		highlight = { enable = true },
		indent = { enable = true },
		autotag = { enable = true },

		ensure_installed = {
			"lua",
			"python",
			"vim",
			"vimdoc",
			"regex",
			"typescript",
			"tsx",
			"javascript",
			"css",
			"scss",
			"sql",
			"gitignore",
			"json",
			"html",
			"markdown",
			"markdown_inline",
			"vue",
			"svelte",
			"astro",
		},
	},
	config = function(_, opts)
		require("nvim-treesitter.configs").setup(opts)
	end,
}
