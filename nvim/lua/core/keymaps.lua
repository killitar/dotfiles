local map = require("helpers.keys").map

--Split window
map("n", "ss", ":split<Return><C-w>w", "Split Window")
map("n", "sv", ":vsplit<Return><C-w>w", "Split Window")

-- Better window navigation
map("n", "<C-h>", "<C-w><C-h>", "Navigate windows to the left")
map("n", "<C-j>", "<C-w><C-j>", "Navigate windows down")
map("n", "<C-k>", "<C-w><C-k>", "Navigate windows up")
map("n", "<C-l>", "<C-w><C-l>", "Navigate windows to the right")

-- Move Lines
map("n", "<A-j>", "<cmd>m .+1<cr>==", "Move line down")
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", "Move line down")
map("v", "<A-j>", ":m '>+1<cr>gv=gv", "Move down")
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", "Move line up")
map("n", "<A-k>", "<cmd>m .-2<cr>==", "Move line up")
map("v", "<A-k>", ":m '<-2<cr>gv=gv", "Move up")

-- Move with shift-arrows
map("n", "<S-Left>", "<C-w><S-h>", "Move window to the left")
map("n", "<S-Down>", "<C-w><S-j>", "Move window down")
map("n", "<S-Up>", "<C-w><S-k>", "Move window up")
map("n", "<S-Right>", "<C-w><S-l>", "Move window to the right")

-- Resize with arrows
map("n", "<C-Up>", ":resize +2<CR>")
map("n", "<C-Down>", ":resize -2<CR>")
map("n", "<C-Right>", ":vertical resize +2<CR>")
map("n", "<C-Left>", ":vertical resize -2<CR>")

--Select all
map("n", "<C-a>", "gg<S-v>G")

-- Stay in indent mode
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Clear search with <esc>
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", "Escape and clear hlsearch")

--Make 'x' key not copy to clipboard when depeting a character
map({ "n", "v" }, "x", function()
	if vim.fn.col(".") == 1 then
		local line = vim.fn.getline(".")
		if line:match("^%s*$") then
			vim.api.nvim_feedkeys("dd", "n", false)
			vim.api.nvim_feedkeys("$", "n", false)
		else
			vim.api.nvim_feedkeys('"_x', "n", false)
		end
	else
		vim.api.nvim_feedkeys('"_x', "n", false)
	end
end, "Delete character without yanking it.")
