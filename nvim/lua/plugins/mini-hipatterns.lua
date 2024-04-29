return {
	"echasnovski/mini.hipatterns",
	event = "BufReadPre",
	opts = function()
		local hi = require("mini.hipatterns")
		return {
			hl = {},
			-- custom option to enable the tailwind integration
			tailwind = {
				enabled = true,
				ft = {
					"typescriptreact",
					"javascriptreact",
					"css",
					"javascript",
					"typescript",
					"html",
					"vue",
					"svelte",
				},
				-- full: the whole css class will be highlighted
				-- compact: only the color will be highlighted
				style = "full",

				-- colors = require("util.tailwind").colors,
			},
			highlighters = {
				hex_color = hi.gen_highlighter.hex_color({ priority = 2000 }),

				-- hsl colors intergation
				hsl_color = {
					pattern = "hsl%(%d+,? %d+%%?,? %d+%%?%)",
					group = function(_, match)
						local utils = require("util.hsl")
						local nh, ns, nl = match:match("hsl%((%d+),? (%d+)%%?,? (%d+)%%?%)")
						--- @type number?, number?, number?
						local h, s, l = tonumber(nh), tonumber(ns), tonumber(nl)
						--- @type string
						local hex_color = utils.hslToHex(h, s, l)
						return hi.compute_hex_color_group(hex_color, "bg")
					end,
				},
			},
		}
	end,
	config = function(_, opts)
		local tailwindColors = require("util.tailwind").colors
		-- backward compatibility
		if opts.tailwind == true then
			opts.tailwind = {
				enabled = true,
				ft = {
					"typescriptreact",
					"javascriptreact",
					"css",
					"javascript",
					"typescript",
					"html",
					"vue",
					"svelte",
				},
				style = "full",
			}
		end
		if type(opts.tailwind) == "table" and opts.tailwind.enabled then
			-- reset hl groups when colorscheme changes
			vim.api.nvim_create_autocmd("ColorScheme", {
				callback = function()
					opts.hl = {}
				end,
			})
			opts.highlighters.tailwind = {
				pattern = function()
					if not vim.tbl_contains(opts.tailwind.ft, vim.bo.filetype) then
						return
					end
					if opts.tailwind.style == "full" then
						return "%f[%w:-]()[%w:-]+%-[a-z%-]+%-%d+()%f[^%w:-]"
					elseif opts.tailwind.style == "compact" then
						return "%f[%w:-][%w:-]+%-()[a-z%-]+%-%d+()%f[^%w:-]"
					end
				end,
				group = function(_, _, m)
					---@type string
					local match = m.full_match
					---@type string, number
					local color, shade = match:match("[%w-]+%-([a-z%-]+)%-(%d+)")
					shade = tonumber(shade)
					local bg = vim.tbl_get(tailwindColors, color, shade)
					if bg then
						local hl = "MiniHipatternsTailwind" .. color .. shade
						if not opts.hl[hl] then
							opts.hl[hl] = true
							local bg_shade = shade == 500 and 950 or shade < 500 and 900 or 100
							local fg = vim.tbl_get(tailwindColors, color, bg_shade)
							vim.api.nvim_set_hl(0, hl, { bg = "#" .. bg, fg = "#" .. fg })
						end
						return hl
					end
				end,
				extmark_opts = { priority = 2000 },
			}
		end
		require("mini.hipatterns").setup(opts)
	end,
}
