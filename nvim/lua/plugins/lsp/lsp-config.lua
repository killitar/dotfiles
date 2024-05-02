return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		{
			"williamboman/mason.nvim",
			cmd = "Mason",
			keys = { { "<leader>M", "<cmd>Mason<cr>", desc = "Mason" } },
			build = ":MasonUpdate",
		},
		"williamboman/mason-lspconfig.nvim",
		"hrsh7th/cmp-nvim-lsp",
		{ "smjonas/inc-rename.nvim", cmd = "IncRename", opts = {} },
		{ "folke/neodev.nvim", opts = {} },
		-- { "pmizio/typescript-tools.nvim", opts = {} },
	},
	config = function()
		local icons = {
			ui = require("helpers.icons").get("ui", true),
			misc = require("helpers.icons").get("misc", true),
		}

		require("mason").setup({
			ui = {
				height = 0.8,
				icons = {
					package_pending = icons.ui.Modified_alt,
					package_installed = icons.ui.Check,
					package_uninstalled = icons.misc.Ghost,
				},
			},
		})
		require("neodev").setup()

		local mason_lspconfig = require("mason-lspconfig")

		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

		local on_attach = function(_, bufnr)
			local lsp_map = require("helpers.keys").lsp_map

			lsp_map("gI", vim.lsp.buf.implementation, bufnr, "Goto Implementation")
			lsp_map("gD", vim.lsp.buf.declaration, bufnr, "Goto Declaration")
			lsp_map("<C-j>", vim.diagnostic.goto_next, bufnr, "Move to the next diagnostic")
			lsp_map("gl", vim.diagnostic.open_float, bufnr, "Show line diagnostics")
			lsp_map("K", vim.lsp.buf.hover, bufnr, "Hover Doc")
			lsp_map("<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
			lsp_map("gd", function()
				require("telescope.builtin").lsp_definitions({ reuse_win = true })
			end, bufnr, "Go to definition")
			lsp_map("gp", function()
				require("telescope.builtin").lsp_implementations({ reuse_win = true })
			end, bufnr, "Goto Implementation")

			vim.keymap.set("n", "gr", function()
				return ":IncRename" .. " " .. vim.fn.expand("<cword")
			end, { expr = true })
			-- lsp_map("gr", ":IncRename " .. vim.fn.expand("<cword>"), bufnr, "Rename")
			lsp_map("<leader>ca", vim.lsp.buf.code_action, bufnr, "Code actions")
		end

		local config = {
			virtual_text = true,
			update_in_insert = true,
			underline = true,
			severity_sort = true,
			float = {
				focusable = true,
				style = "minimal",
				border = "rounded",
				source = "always",
				header = "",
				prefix = "",
			},
		}
		vim.diagnostic.config(config)

		local servers = {
			lua_ls = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
					workspace = { checkThirdParty = false },
					telemetry = { enable = false },
				},
			},
			tsserver = {
				plugins = {
					{
						name = "@vue/typescript-plugin",
						location = require("mason-registry").get_package("vue-language-server"):get_install_path()
							.. "/node_modules/@vue/language-server"
							.. "/node_modules/@vue/typescript-plugin",
						languages = { "javascript", "typescript", "vue" },
					},
				},
				filetypes = {
					"javascript",
					"javascriptreact",
					"javascript.jsx",
					"typescript",
					"typescriptreact",
					"typescript.tsx",
					"vue",
				},
			},
			pyright = {},

			volar = {},
			svelte = {},
			astro = {},
			html = {},
			emmet_language_server = {},
			cssls = {},
			tailwindcss = {},
		}

		mason_lspconfig.setup({
			ensure_installed = vim.tbl_keys(servers),
		})

		mason_lspconfig.setup_handlers({
			function(server_name)
				require("lspconfig")[server_name].setup({
					capabilities = capabilities,
					on_attach = on_attach,
					settings = servers[server_name],
					init_options = servers[server_name],
					filetypes = servers[server_name].filetypes,
				})
			end,
		})
	end,
}
