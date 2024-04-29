return {
	"hrsh7th/nvim-cmp",
	version = false,
	event = "InsertEnter",
	dependencies = {
		{
			"L3MON4D3/LuaSnip",
			dependencies = {
				"rafamadriz/friendly-snippets",
				"saadparwaiz1/cmp_luasnip",
			},
			config = function()
				require("luasnip.loaders.from_vscode").lazy_load()
			end,
		},
		{
			"Exafunction/codeium.nvim",
			event = { "BufRead", "BufNewFile" },
			opts = true,
		},

		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"lukas-reineke/cmp-under-comparator",
	},
	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")
		local icons = {
			kind = require("helpers.icons").get("kind", true),
			type = require("helpers.icons").get("type"),
			cmp = require("helpers.icons").get("cmp"),
		}

		local check_backspace = function()
			local col = vim.fn.col(".") - 1
			return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
		end

		vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
		vim.opt.shortmess:append("c")

		cmp.setup({
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			experimental = {
				ghost_text = {
					hl_group = "CmpGhostText",
				},
			},
			sorting = {
				priority_weight = 1,
				comparators = {
					cmp.config.compare.scopes,
					cmp.config.compare.locality,
					require("cmp-under-comparator").under,
					cmp.config.compare.recently_used,

					cmp.config.compare.score,
					cmp.config.compare.offset,
					-- compare.sort_text,
					-- compare.length,
					-- compare.order,
				},
			},

			-- matching = {
			--   disallow_fuzzy_matching = true,
			--   disallow_fullfuzzy_matching = true,
			--   disallow_partial_fuzzy_matching = true,
			--   disallow_partial_matching = false,
			--   disallow_prefix_unmatching = true,
			-- },

			view = { entries = { name = "custom", selection_order = "top_down" } },

			window = {
				documentation = {
					border = "rounded",
					-- winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:CursorLine,Search:None",
					winhighlight = "Normal:CmpDoc",
					max_width = 80,
					max_height = 20,
				},
				completion = {
					border = "rounded",
					winhighlight = "Normal:CmpPmenu,CursorLine:CursorLine,Search:None",
					-- winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:CursorLine,Search:None",
					scrollbar = false,
				},
			},

			completion = {
				-- Remove open paren and comma from completion triggers.
				get_trigger_characters = function(trigger_characters)
					local new_trigger_characters = {}
					for _, char in ipairs(trigger_characters) do
						if char ~= "(" and char ~= "," then
							table.insert(new_trigger_characters, char)
						end
					end
					return new_trigger_characters
				end,
			},
			confirm_opts = {
				behavior = cmp.ConfirmBehavior.Replace,
				select = false,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-k>"] = cmp.mapping.select_prev_item(),
				["<C-j>"] = cmp.mapping.select_next_item(),
				["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
				["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
				["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
				["<C-e>"] = cmp.mapping({
					i = cmp.mapping.abort(),
					c = cmp.mapping.close(),
				}),
				-- Accept currently selected item. If none selected, `select` first item.
				-- Set `select` to `false` to only confirm explicitly selected items.
				["<CR>"] = cmp.mapping.confirm({ select = false }),

				-- Use TAB and Shift-TAB to scroll through suggestions
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					elseif luasnip.expandable() then
						luasnip.expand()
					elseif luasnip.expand_or_jumpable() then
						luasnip.expand_or_jump()
					elseif check_backspace() then
						fallback()
					else
						fallback()
					end
				end, {
					"i",
					"s",
				}),
				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, {
					"i",
					"s",
				}),
			}),
			formatting = {
				fields = { "abbr", "kind", "menu" },
				expandable_indicator = true,
				format = function(_, item)
					local icon = icons.kind[item.kind]

					item.kind = string.format("%s %s", icon, item.kind or "")
					return item
				end,
			},
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "codeium" },
				{
					name = "luasnip",
					entry_filter = function()
						local context = require("cmp.config.context")
						return not context.in_treesitter_capture("string") and not context.in_syntax_group("String")
					end,
				},
			}, {
				{ name = "path" },
			}, {
				{
					name = "buffer",
					option = {
						get_bufnrs = function()
							local bufs = {}
							for _, win in ipairs(vim.api.nvim_list_wins()) do
								bufs[vim.api.nvim_win_get_buf(win)] = true
							end
							return vim.tbl_keys(bufs)
						end,
					},
				},
			}),
		})
	end,
}
