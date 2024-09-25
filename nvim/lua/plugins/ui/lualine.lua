return {
	"nvim-lualine/lualine.nvim",
	enabled = false,
	event = "VeryLazy",
	init = function()
		vim.g.lualine_laststatus = vim.o.laststatus
		if vim.fn.argc(-1) > 0 then
			-- set an empty statusline till lualine loads
			vim.o.statusline = " "
		else
			-- hide the statusline on the starter page
			vim.o.laststatus = 0
		end
	end,
	opts = function()
		vim.o.laststatus = vim.g.lualine_laststatus

		local lazy_status = require("lazy.status")

		return {
			options = {
				icons_enabled = true,
				theme = "auto",
				section_separators = { left = "", right = "" },
				component_separators = "|",
				globalstatus = true,
				disabled_filetypes = { statusline = { "dashboard", "alpha", "ministarter" } },
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch" },
				lualine_c = {},
				lualine_x = {
					{
						lazy_status.updates,
						cond = lazy_status.has_updates,
					},
					{
						"diagnostics",
						sources = { "nvim_diagnostic" },
					},
					{
						"filename",
						file_status = true, -- displays file status (readonly status, modified status)
						path = 4, -- 0 = just filename, 1 = relative path, 2 = absolute path
					},
				},
				lualine_y = {
					{
						"filetype",
						icon_only = true,
					},
					"encoding",
				},
				lualine_z = { "location" },
			},
			extensions = { "neo-tree", "lazy", "trouble" },
		}
	end,
}
