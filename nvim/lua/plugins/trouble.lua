return {
	"folke/trouble.nvim",
	cmd = { "TroubleToggle", "Trouble" },
	dependencies = { "nvim-tree/nvim-web-devicons" },
	keys = {
		{ "<leader>xx", "<cmd>TroubleToggle document_diagnostics <CR>", desc = "Document Diagnostics (Trouble)" },
		{ "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" },
		{ "<leader>xl", "<cmd>TroubleToggle loclist<cr>", desc = "Location List (Trouble)" },
		{ "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", desc = "Quickfix List (Trouble)" },
	},
	opts = {
		use_diagnostic_signs = true,
	},
}
