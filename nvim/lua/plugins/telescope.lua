return {
	"nvim-telescope/telescope.nvim",
	cmd = "Telescope",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make", cond = vim.fn.executable("make") == 1 },
		"ahmedkhalf/project.nvim",
		"debugloop/telescope-undo.nvim",
	},
	keys = {
		{ ";f", "<cmd>Telescope find_files<cr>", desc = "Find files" },
		{ ";t", "<cmd>Telescope help_tags<cr>", desc = "Help" },
		{ ";r", "<cmd>Telescope live_grep<cr>", desc = "Grep" },
		{ ";e", "<cmd>Telescope diagnostics<cr>", desc = "Lsp Diagnostics" },
		{ ";p", "<cmd>Telescope projects<cr>", desc = "Projects" },
		{ ";u", "<cmd>Telescope undo<cr>", desc = "Undo history" },
		{ "<C-p>", "<cmd>Telescope keymaps<cr>", desc = "Search keymaps" },
		{ "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recently opened" },
		{ "<leader><space>", "<cmd>Telescope buffers<cr>", desc = "Open buffers" },
		{
			"<leader>/",
			function()
				return require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
					previewer = false,
				}))
			end,
			desc = "Search in current buffer",
		},
	},
	opts = function()
		local actions = require("telescope.actions")
		local telescope = require("telescope")
		local icons = require("helpers.icons").get("ui", true)
		return {
			defaults = {
				prompt_prefix = icons.Search,
				selection_caret = icons.Separator,
				layout_config = { prompt_position = "top" },
				path_display = { "filename_first" },
				sorting_strategy = "ascending",
				mappings = {
					i = {
						["<C-u>"] = false,
						["<C-d>"] = false,
					},
					n = {
						["q"] = actions.close,
					},
				},
				extensions = {
					undo = {
						side_by_side = true,
						layout_strategy = "vertical",
						layout_config = {
							preview_height = 0.8,
						},
					},
				},
			},
			pickers = {
				diagnostics = {
					theme = "ivy",
					initial_mode = "normal",
				},
			},

			telescope.load_extension("fzf"),
			telescope.load_extension("projects"),
			telescope.load_extension("undo"),
		}
	end,
}
