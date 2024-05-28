-- Install lazy.nvim if not already installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	-- bootstrap lazy.nvim
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath, ---latest lazy stable release
	})
end
vim.opt.rtp:prepend(lazypath)

-- Use a protected call so we don't error out on first use
local ok, lazy = pcall(require, "lazy")
if not ok then
	return
end

require("helpers.keys").set_leader(" ") -- Need setup mapleader key before lazy

-- Load plugins from specifications
lazy.setup({
	spec = {
		{ import = "plugins.colorschemes" },
		{ import = "plugins.ui" },
		{ import = "plugins.lsp" },
		{ import = "plugins" },
	},
	ui = {
		icons = {
			--   lazy = "󰂠 ",
			ft = " ",
			loaded = " ",
			not_loaded = " ",
		},
	},
	defaults = {
		lazy = true,
		version = false,
	},
	install = { colorscheme = { "solarized-osaka" } },
	checker = {
		enabled = true,
		notify = false,
	},
	change_detection = {
		notify = false,
	},
	performance = {
		rtp = {
			disabled_plugins = { "tohtml", "gzip", "zipPlugin", "netrwPlugin", "tarPlugin", "tutor" },
		},
	},
})

require("helpers.keys").map("n", "<leader>L", lazy.show, "Show Lazy")

vim.cmd.colorscheme("solarized-osaka")
