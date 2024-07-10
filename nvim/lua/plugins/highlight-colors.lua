return {
	"brenoprata10/nvim-highlight-colors",
	event = "BufReadPre",
	opts = {
		enable_tailwind = true,
		exclude_filetypes = {
			"Telescope",
			"lazy",
			"mason",
			"lazyterm",
			"toggleterm",
		},
	},
}
