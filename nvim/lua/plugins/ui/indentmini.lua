return {
	"nvimdev/indentmini.nvim",
	event = "BufEnter",
	enabled = true,
	config = function()
		require("indentmini").setup({
			only_current = true,
			minlevel = 2,
			char = "╎",
		})
		vim.cmd("hi! link IndentLine IndentBlanklineChar")
		vim.cmd("hi! link IndentLineCurrent IndentBlanklineContextChar")
	end,
}
