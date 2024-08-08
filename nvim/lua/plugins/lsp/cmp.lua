return {
	"hrsh7th/nvim-cmp",
	version = false,
	event = "InsertEnter",
	dependencies = {
		{
			"garymjr/nvim-snippets",
			dependencies = { "rafamadriz/friendly-snippets" },
			opts = {
				friendly_snippets = true,
			},
		},

		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		{
			url = "https://codeberg.org/FelipeLema/cmp-async-path.git",
		},
		"folke/lazydev.nvim",
		"lukas-reineke/cmp-under-comparator",
	},
	config = function()
		local cmp = require("cmp")

		local has_words_before = function()
			unpack = unpack or table.unpack
			local line, col = unpack(vim.api.nvim_win_get_cursor(0))
			return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
		end

		vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
		vim.opt.shortmess:append("c")

		cmp.setup({
			experimental = {
				ghost_text = {
					hl_group = "CmpGhostText",
				},
			},
			sorting = {
				priority_weight = 1,
				comparators = {
					cmp.config.compare.offset,
					cmp.config.compare.exact,
					cmp.config.compare.score,
					require("cmp-under-comparator").under,
					cmp.config.compare.kind,
					cmp.config.compare.recently_used,
					cmp.config.compare.locality,
				},
			},

			matching = {
				disallow_fuzzy_matching = true,
				disallow_fullfuzzy_matching = true,
				disallow_partial_fuzzy_matching = true,
				disallow_partial_matching = false,
				disallow_prefix_unmatching = true,
				disallow_symbol_nonprefix_matching = false,
			},

			view = {
				entries = {
					name = "custom",
					selection_order = "top_down",
					follow_cursor = true,
				},
			},

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
				},
			},

			completion = {
				-- Remove open paren, comma and "" from completion triggers.
				get_trigger_characters = function(trigger_characters)
					local new_trigger_characters = {}
					for _, char in ipairs(trigger_characters) do
						if char ~= "(" and char ~= "," and char ~= '"' and char ~= "'" then
							table.insert(new_trigger_characters, char)
						end
					end
					return new_trigger_characters
				end,
				keyword_length = 2,
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
					elseif vim.snippet.active({ direction = 1 }) then
						vim.schedule(function()
							vim.snippet.jump(1)
						end)
					elseif has_words_before() then
						cmp.complete()
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
					elseif vim.snippet.active({ direction = -1 }) then
						vim.schedule(function()
							vim.snippet.jump(-1)
						end)
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
					local mini_icon = require("mini.icons").get("lsp", item.kind)

					item.kind = string.format("%s %s", mini_icon, item.kind or "")
					return item
				end,
			},
			sources = cmp.config.sources({
				{
					name = "snippets",
					max_item_count = 3,
					entry_filter = function()
						local context = require("cmp.config.context")
						return not context.in_treesitter_capture("string") and not context.in_syntax_group("String")
					end,
				},
				{ name = "nvim_lsp", max_item_count = 5 },
				{ name = "lazydev", keyword_length = 2, group_index = 0 },
			}, {
				{ name = "async_path" },
			}, {
				{
					name = "buffer",
					keyword_length = 3,
					max_item_count = 5,
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
