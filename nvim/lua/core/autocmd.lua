-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight on yank",
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "text", "plaintex", "typst", "gitcommit", "markdown" },
  callback = function()
    vim.opt.wrap = true
    vim.opt_local.spell = true
  end,
})

-- Turn off paste mode when leaving insert
vim.api.nvim_create_autocmd("InsertLeave", {
  desc = "Turn off paste mode when leaving insert",
  pattern = "*",
  command = "set nopaste",
})

-- Fix conceallevel for json files
vim.api.nvim_create_autocmd({ "FileType" }, {
  desc = "Fix conceallevel for json files",
  pattern = { "json", "jsonc", "json5" },
  callback = function()
    vim.opt_local.conceallevel = 0
  end,
})

--Don't autostart new comment line after a comment
vim.api.nvim_create_autocmd({ "BufEnter" }, {
  desc = "Don't autostart new comment line after a comment",
  callback = function()
    vim.cmd("set formatoptions-=cro")
  end,
})

-- Disable Statusline highlight
vim.api.nvim_create_autocmd({ "BufEnter" }, {
  callback = function()
    vim.cmd("highlight statusline ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE")
  end,
})

-- Hide tildas on dashboard screen
vim.api.nvim_create_autocmd({ "FileType" }, {
  desc = "Hide tildas on dashboard screen",
  pattern = { "dashboard" },
  callback = function()
    vim.opt_local.fillchars:append({ eob = " " })
  end,
})

-- Auto close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  desc = "Auto close some filetypes with <q>",
  pattern = {
    "qf",
    "query",
    "help",
    "man",
    "notify",
    "nofile",
    "lspinfo",
    "terminal",
    "prompt",
    "toggleterm",
    "copilot",
    "startuptime",
    "tsplayground",
    "PlenaryTestPopup",
    "fugitive",
    "gitsigns-blame",
    "dap-repl",
    "spectre_panel",
    "Jaq",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.api.nvim_buf_set_keymap(event.buf, "n", "q", "<CMD>close<CR>", { silent = true })
  end,
})
