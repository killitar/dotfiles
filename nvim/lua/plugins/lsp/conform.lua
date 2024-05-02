return {
	"stevearc/conform.nvim",
	dependencies = { "mason.nvim" },
	event = "BufWritePre",
	cmd = "ConformInfo",
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			-- Conform will run multiple formatters sequentially
			python = { "isort", "black" },
			-- Use a sub-list to run only the first available formatter
			javascript = { { "eslint_d", "prettierd", "prettier" } },
			javascriptreact = { { "eslint_d", "prettierd", "prettier" } },
			typescript = { { "eslint_d", "prettierd", "prettier" } },
			typescriptreact = { { "eslint_d", "prettierd", "prettier" } },
			vue = { { "eslint_d", "prettierd", "prettier" } },
			svelte = { { "eslint_d", "prettierd", "prettier" } },
			astro = { { "eslint_d", "prettierd", "prettier" } },
			css = { { "prettierd", "prettier" } },
			scss = { { "prettierd", "prettier" } },
			less = { { "prettierd", "prettier" } },
			html = { { "eslint_d", "prettierd", "prettier" } },
			json = { { "eslint_d", "prettierd", "prettier" } },
			jsonc = { { "eslint_d", "prettierd", "prettier" } },
			yaml = { { "eslint_d", "prettierd", "prettier" } },
			markdown = { { "eslint_d", "prettierd", "prettier" }, "markdownlint", "markdown-toc" },
			graphql = { { "eslint_d", "prettierd", "prettier" } },
			handlers = { { "prettierd", "prettier" } },

			-- Use the "_" filetype to run formatters on filetypes that don't
			-- have other formatters configured.
			["_"] = { "trim_whitespace" },
		},
		-- format_on_save = {
		--   -- These options will be passed to conform.format()
		--   timeout_ms = 500,
		--   lsp_fallback = true,
		-- },
		format_after_save = {
			lsp_fallback = true,
		},

		log_level = vim.log.levels.ERROR,
		notify_on_error = true,
	},
}
