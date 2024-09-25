return {
	"rebelot/heirline.nvim",
	event = "UIEnter",
	config = function()
		local conditions = require("heirline.conditions")
		local utils = require("heirline.utils")
		local colors = require("obscure.palettes").get_palette("obscure")
		local icons = {
			diagnostics = require("helpers.icons").get("diagnostics", true),
			git = require("helpers.icons").get("git", true),
		}

		local separator = { left = "", right = "" }

		local Align = { provider = "%=" }
		local Space = { provider = " " }

		local Mode = {
			init = function(self)
				self.mode = vim.fn.mode(1)
			end,
			update = {
				"ModeChanged",
				pattern = "*:*",
				callback = vim.schedule_wrap(function()
					vim.cmd("redrawstatus")
				end),
			},
			static = {
				mode_names = {
					["n"] = "NORMAL",
					["no"] = "O-PENDING",
					["nov"] = "O-PENDING",
					["noV"] = "O-PENDING",
					["no\22"] = "O-PENDING",
					["niI"] = "NORMAL",
					["niR"] = "NORMAL",
					["niV"] = "NORMAL",
					["nt"] = "NORMAL",
					["ntT"] = "NORMAL",
					["v"] = "VISUAL",
					["vs"] = "VISUAL",
					["V"] = "V-LINE",
					["Vs"] = "V-LINE",
					["\22"] = "V-BLOCK",
					["\22s"] = "V-BLOCK",
					["s"] = "SELECT",
					["S"] = "S-LINE",
					["\19"] = "S-BLOCK",
					["i"] = "INSERT",
					["ic"] = "INSERT",
					["ix"] = "INSERT",
					["R"] = "REPLACE",
					["Rc"] = "REPLACE",
					["Rx"] = "REPLACE",
					["Rv"] = "V-REPLACE",
					["Rvc"] = "V-REPLACE",
					["Rvx"] = "V-REPLACE",
					["c"] = "COMMAND",
					["cv"] = "EX",
					["ce"] = "EX",
					["r"] = "REPLACE",
					["rm"] = "MORE",
					["r?"] = "CONFIRM",
					["!"] = "SHELL",
					["t"] = "TERMINAL",
				},

				mode_colors = {
					n = colors.red,
					i = colors.cyan,
					v = colors.purple,
					V = colors.red,
					["\22"] = colors.purple,
					c = colors.yellow,
					cv = colors.red,
					ce = colors.red,
					no = colors.red,
					s = colors.yellow,
					S = colors.yellow,
					["\19"] = colors.yellow,
					R = colors.green,
					Rv = colors.purple,
					r = colors.cyan,
					rm = colors.cyan,
					["r?"] = colors.cyan,
					["!"] = colors.red,
					t = colors.bright_red,
				},
			},
			{
				provider = separator.left,
				hl = function(self)
					local mode = self.mode:sub(1, 1)
					return { fg = self.mode_colors[mode], bg = colors.bg_dark }
				end,
			},
			{
				provider = function(self)
					return (" %s "):format(self.mode_names[self.mode])
				end,
			},

			{
				provider = separator.right,
				hl = function(self)
					local mode = self.mode:sub(1, 1)
					return { fg = self.mode_colors[mode], bg = colors.bg_dark }
				end,
			},

			hl = function(self)
				local mode = self.mode:sub(1, 1)
				return { fg = colors.bg_dark, bg = self.mode_colors[mode], bold = true }
			end,
		}

		local FileNameBlock = {
			{
				provider = separator.left,
				hl = { bg = colors.bg_dark, fg = colors.blue },
			},
			init = function(self)
				self.filename = vim.api.nvim_buf_get_name(0)
			end,
			hl = { bg = colors.blue },
		}

		local FileName = {
			provider = function(self)
				local filename = vim.fn.fnamemodify(self.filename, ":t")
				if filename == "" then
					return " [No Name] "
				end
				return (" %s "):format(filename)
			end,
			hl = { fg = colors.bg_dark, bold = true },
		}
		local FileNameModifer = {
			hl = function()
				if vim.bo.modified then
					return { fg = colors.bg_dark, bold = true, force = true }
				end
			end,
		}

		FileNameBlock = utils.insert(
			FileNameBlock,
			utils.insert(FileNameModifer, FileName),
			{
				provider = separator.right,
				hl = function()
					local bg_color = colors.bg_dark
					if vim.bo.filetype ~= "" then
						bg_color = colors.gray2
					end
					return { fg = colors.blue, bg = bg_color }
				end,
			},
			{ provider = "%<" } -- this means that the statusline is cut here when there's not enough space
		)

		local FileType = {
			condition = function()
				return vim.bo.filetype ~= ""
			end,
			{
				provider = function()
					return (" %s "):format(string.lower(vim.bo.filetype))
				end,
			},
			{
				provider = separator.right,
				hl = { fg = colors.gray2, bg = colors.bg_dark },
			},
			hl = { fg = colors.blue, bg = colors.gray2, bold = true, italic = true },
		}

		local Git = {
			condition = conditions.is_git_repo,
			init = function(self)
				self.status_dict = vim.b.gitsigns_status_dict
				self.has_changes = self.status_dict.added ~= 0
					or self.status_dict.removed ~= 0
					or self.status_dict.changed ~= 0
			end,
			static = {
				git_branch_icon = icons.git.Branch,
				git_add_icon = icons.git.Add,
				git_remove_icon = icons.git.Remove,
				git_change_icon = icons.git.Mod_alt,
			},

			{
				provider = separator.left,
				hl = { fg = colors.green, bg = colors.bg_dark },
			},
			{
				provider = function(self)
					return " " .. self.git_branch_icon .. self.status_dict.head .. " "
				end,
				hl = { bold = true },
			},
			{
				provider = separator.right,
				hl = function(self)
					local bg_color = colors.bg_dark
					if self.has_changes then
						bg_color = colors.gray2
					end
					return { fg = colors.green, bg = bg_color, bold = true }
				end,
			},
			{
				{
					provider = function(self)
						local count = self.status_dict.added or 0
						return count > 0 and (" " .. self.git_add_icon .. count)
					end,
					hl = { fg = colors.bright_green },
				},
				{
					provider = function(self)
						local count = self.status_dict.removed or 0
						return count > 0 and (" " .. self.git_remove_icon .. count)
					end,
					hl = { fg = colors.bright_orange },
				},
				{
					provider = function(self)
						local count = self.status_dict.changed or 0
						return count > 0 and (" " .. self.git_change_icon .. count)
					end,
					hl = { fg = colors.bright_yellow },
				},
				{
					condition = function(self)
						return self.has_changes
					end,
					provider = separator.right,
					hl = { fg = colors.gray2, bg = colors.bg_dark },
				},
				hl = { bg = colors.gray2 },
			},
			hl = { fg = colors.bg_dark, bg = colors.green },
		}

		local Ruler = {
			{
				provider = separator.left,
				hl = { fg = colors.yellow, bg = colors.bg_dark },
			},
			{
				provider = " %c:%l ",
			},
			{
				provider = separator.right,
				hl = { fg = colors.yellow, bg = colors.bg_dark },
			},
			hl = { fg = colors.bg_dark, bg = colors.yellow },
		}

		local Diagnostics = {
			condition = conditions.has_diagnostics(),
			init = function(self)
				self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
				self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
				self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
				self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
			end,
			update = { "DiagnosticChanged", "BufEnter" },
			static = {
				error_icon = icons.diagnostics.Error_alt,
				warn_icon = icons.diagnostics.Warning_alt,
				info_icon = icons.diagnostics.Information_alt,
				hint_icon = icons.diagnostics.Hint_alt,
			},
			on_click = {
				callback = function()
					require("telescope.builtin").diagnostics({
						layout_strategy = "center",
						bufnr = 0,
					})
				end,
				name = "sl_diagnostics_click",
			},

			{
				{
					condition = conditions.has_diagnostics,
					provider = separator.left,
					hl = { fg = colors.gray2, bg = colors.bg_dark },
				},
				{
					provider = function(self)
						return self.errors > 0 and (self.error_icon .. self.errors .. " ")
					end,
					hl = { fg = colors.red },
				},
				{
					provider = function(self)
						return self.warnings > 0 and (self.warn_icon .. self.warnings .. " ")
					end,
					hl = { fg = colors.yellow },
				},
				{
					provider = function(self)
						return self.info > 0 and (self.info_icon .. self.info .. " ")
					end,
					hl = { fg = colors.purple },
				},
				{
					provider = function(self)
						return self.hints > 0 and (self.hint_icon .. self.hints .. " ")
					end,
					hl = { fg = colors.cyan },
				},
				hl = { fg = colors.bg_dark, bg = colors.gray2 },
			},
		}

		local LSPActive = {
			update = {
				"LspAttach",
				"LspDetach",
				"BufEnter",
				"DiagnosticChanged",
			},
			on_click = {
				callback = function()
					vim.defer_fn(function()
						vim.cmd("LspInfo")
					end, 100)
				end,
				name = "sl_lsp_click",
			},
			{
				provider = separator.left,
				hl = function()
					local bg_color = colors.bg_dark
					if conditions.has_diagnostics() then
						bg_color = colors.gray2
					end
					return { fg = colors.purple, bg = bg_color }
				end,
			},
			{
				provider = function()
					local bufnr = vim.api.nvim_get_current_buf()
					local buf_clients = vim.lsp.get_clients({ bufnr = bufnr })
					local buf_client_names = {}

					local hash = {}
					local unique_client_names = {}

					if next(buf_clients) == nil then
						return "   No servers "
					end

					for _, client in pairs(buf_clients) do
						if client.name ~= "null-ls" then
							table.insert(buf_client_names, client.name)
						end
					end

					for _, v in ipairs(buf_client_names) do
						if not hash[v] then
							unique_client_names[#unique_client_names + 1] = v
							hash[v] = true
						end
					end
					local language_servers = table.concat(unique_client_names, ", ")

					return "   " .. language_servers .. " "
				end,
			},
			{
				provider = separator.right,
				hl = { fg = colors.purple, bg = colors.bg_dark },
			},
			hl = { fg = colors.bg_dark, bg = colors.purple, bold = true, italic = true },
		}

		local LazyUpdates = {
			condition = function()
				local ok, lazy_status = pcall(require, "lazy.status")
				return ok and lazy_status.has_updates()
			end,
			on_click = {
				callback = function()
					vim.defer_fn(function()
						vim.cmd("Lazy")
					end, 100)
				end,
				name = "sl_lazy_click",
			},
			{
				provider = separator.left,
				hl = { fg = colors.cyan, bg = colors.bg_dark },
			},
			{
				provider = function()
					return " " .. require("lazy.status").updates() .. " "
				end,
			},

			{
				provider = separator.right,
				hl = { fg = colors.cyan, bg = colors.bg_dark },
			},
			hl = { fg = colors.bg_dark, bg = colors.cyan, bold = true },
		}

		local LazyStats = {
			condition = function()
				local ok, lazy = pcall(require, "lazy")
				return ok and lazy.stats()
			end,
			{
				provider = function()
					return " "
						.. "loaded:"
						.. require("lazy").stats().loaded
						.. "/"
						.. require("lazy").stats().count
						.. " "
				end,
			},

			{
				provider = separator.right,
				hl = { fg = colors.gray2, bg = colors.bg_dark },
			},
			hl = { fg = colors.purple, bg = colors.gray2, bold = true, italic = true },
		}

		local DefaultStatusLine = {
			Mode,
			Space,
			Space,
			FileNameBlock,
			FileType,
			Space,
			Space,
			Git,
			Space,
			Ruler,
			Space,
			LazyUpdates,
			Align,
			Diagnostics,
			LSPActive,
			hl = { bg = colors.bg_dark },
		}

		local LazyStatusLine = {
			condition = function()
				return conditions.buffer_matches({
					filetype = { "lazy" },
				})
			end,

			{
				{
					provider = separator.left,
					hl = { fg = colors.purple, bg = colors.bg_dark },
				},
				{
					provider = "💤 lazy ",
					hl = { fg = colors.bg_dark, bg = colors.purple, bold = true },
				},
				{
					provider = separator.right,
					hl = { fg = colors.purple, bg = colors.gray2 },
				},
			},
			LazyStats,
			Space,
			LazyUpdates,
			Align,
			hl = { bg = colors.bg_dark },
		}

		local DisableStatusLine = {
			condition = function()
				return conditions.buffer_matches({
					filetype = { "dashboard", "alpha", "ministarter" },
				})
			end,
		}

		local StatusLines = {
			hl = function()
				if conditions.is_active() then
					return "StatusLine"
				else
					return "StatusLineNC"
				end
			end,

			fallthrough = false,
			LazyStatusLine,
			DisableStatusLine,
			DefaultStatusLine,
		}

		require("heirline").setup({
			statusline = StatusLines,
			opts = { colors = colors },
		})
	end,
}
