return {
	"JoosepAlviste/nvim-ts-context-commentstring",
	opts = {
		enable_autocmd = false,
	},
	init = function()
		vim.schedule(function()
			local get_option = vim.filetype.get_option

			vim.filetype.get_option = function(filetype, option)
				return option == "commentstring"
						and require("ts_context_commentstring.internal").calculate_commentstring()
					or get_option(filetype, option)
			end
		end)
	end,
}
