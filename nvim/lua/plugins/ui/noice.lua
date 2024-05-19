return {
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = {
		"MunifTanjim/nui.nvim",
		"rcarriga/nvim-notify",
	},
	opts = {
		lsp = {
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
				["cmp.entry.get_documentation"] = true,
			},
		},
		routes = {
			{
				filter = {
					event = "msg_show",
					any = {
						{ find = "%d+L, %d+B" },
						{ find = "; after #%d+" },
						{ find = "; before #%d+" },
					},
				},
				view = "mini",
			},
			{ filter = {
				event = "notify",
				find = "No information available",
			}, skip = true },
			{
				filter = {
					event = "lsp",
					kind = "progress",
					any = {
						{ find = "Diagnosing" },
						{ find = "Processing full" },
						{ find = "Processing completion" },
					},
				},
				skip = true,
			},
		},
		presets = {
			lsp_doc_border = true,
			bottom_search = true,
			command_palette = true,
			long_message_to_split = true,
			inc_rename = true,
		},
	},
}
