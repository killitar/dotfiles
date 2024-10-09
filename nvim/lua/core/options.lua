local opt = vim.opt

vim.g.root_spec = { "lsp", { ".git", "lua" }, "cwd" }

vim.g.deprecation_warnings = false -- hide deprecation_warnings

--clipboard
opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus"

-- True color support
opt.termguicolors = true

opt.list = true -- visible whitespace characters

--File encoding
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"

-- Indent options
opt.shiftwidth = 2
opt.softtabstop = 2
opt.tabstop = 2
opt.expandtab = true
opt.smartindent = true
opt.shiftround = true

--Context
opt.scrolloff = 4
opt.sidescrolloff = 8

-- Line numbers
opt.number = true
opt.relativenumber = true

--Mause
opt.mouse = "a"
opt.mousefocus = true

--Splits
opt.splitbelow = true
opt.splitright = true

opt.smartcase = true
opt.ignorecase = true

opt.pumheight = 10 -- Height of the pop up menu
opt.winminwidth = 5 -- Minimum window width

opt.laststatus = 3 -- global statusline
opt.showmode = false -- Dont show mode since we have a statusline
opt.cursorline = true
opt.signcolumn = "yes"
opt.wrap = false
opt.title = false
opt.backup = false
opt.writebackup = false
opt.swapfile = false
opt.conceallevel = 2 -- Hide * markup for bold and italic, but not markers with substitutions

opt.formatoptions = "1jcroql"
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep --smart-case"
opt.completeopt = "menu,menuone,noselect"
opt.virtualedit = "block" -- Allow cursor to move where there is no text in visual block mode

opt.timeoutlen = 300

opt.undofile = true
opt.undolevels = 10000

opt.wildmenu = true
opt.wildmode = "longest:full,full"

opt.langmap =
  "ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz"
opt.spelllang = { "en" }

--Fillchars
opt.fillchars = {
  foldopen = "",
  foldclose = "",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = "~",
}

opt.smoothscroll = true

vim.g.markdown_recommended_style = 0

--clipboard wsl
if vim.fn.has("wsl") == 1 then
  vim.g.clipboard = {
    name = "win32yank-wsl",
    copy = {
      ["+"] = "clip.exe",
      ["*"] = "clip.exe",
    },
    paste = {
      ["+"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
      ["*"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
    },
    cache_enable = 0,
  }
end
