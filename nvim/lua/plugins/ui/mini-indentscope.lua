return {
	"echasnovski/mini.indentscope",
	enabled = false,
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		options = { try_as_border = true },
	},
	init = function()
		vim.api.nvim_create_autocmd("FileType", {
			pattern = {
				"help",
				"markdown",
				"alpha",
				"dashboard",
				"ministarter",
				"neo-tree",
				"Trouble",
				"trouble",
				"lazy",
				"mason",
				"notify",
				"toggleterm",
				"lazyterm",
			},
			callback = function()
				vim.b.miniindentscope_disable = true
			end,
		})
	end,
}
