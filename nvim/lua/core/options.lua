local opt = vim.opt

vim.g.root_spec = { "lsp", { ".git", "lua" }, "cwd" }

--clipboard
opt.clipboard = { "unnamed", "unnamedplus" }

--File encoding
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"
opt.fileformats = "unix,mac,dos"

-- opt.list = true

-- Indent options
opt.shiftwidth = 2
opt.tabstop = 2
opt.expandtab = true
opt.smartindent = true
opt.smarttab = true
opt.breakindent = true

opt.backspace = "indent,eol,start"

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

opt.pumheight = 10   -- Height of the pop up menu
opt.winminwidth = 5  -- Minimum window width

opt.laststatus = 3   -- global statusline
opt.showmode = false -- Dont show mode since we have a statusline
opt.cursorline = true
opt.signcolumn = "yes"
opt.cursorcolumn = false
opt.wrap = false
opt.title = false
opt.backup = false
opt.backupskip = "/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*,/private/var/*,.vault.vim"
opt.writebackup = false
opt.breakat = [[\ \	;:,!?]]
opt.breakindentopt = "shift:2,min:20"
opt.termguicolors = true
opt.conceallevel = 2 -- Hide * markup for bold and italic, but not markers with substitutions

opt.formatoptions = "1jcroql"
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --hidden --vimgrep --smart-case --"
opt.history = 2000
opt.completeopt = "menu,menuone,noselect"
opt.virtualedit = "block" -- Allow cursor to move where there is no text in visual block mode

opt.timeoutlen = 300

opt.undofile = true
opt.whichwrap = "h,l,<,>,[,],~"

opt.path:append({ "**" })
opt.wildignore =
".git,.hg,.svn,*.pyc,*.o,*.out,*.jpg,*.jpeg,*.png,*.gif,*.zip,**/tmp/**,*.DS_Store,**/node_modules/**,**/bower_modules/**"

opt.langmap =
"ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz"
opt.spelllang = { "en", "ru" }

--Fillchars
opt.fillchars = {
  foldopen = "",
  foldclose = "",
  -- fold = "⸱",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = "~",
}

vim.g.markdown_recommended_style = 0

--Undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])

--clipboard wsl
if vim.fn.has("wsl") == 1 then
  vim.g.clipboard = {
    name = "win32yank-wsl",
    copy = {
      ["+"] = "clip.exe",
      ["*"] = "clip.exe"
    },
    paste = {
      ["+"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
      ["*"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))'
    },
    cache_enable = 0,
  }
end
