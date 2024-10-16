local M = {}
local utils = require("heirline.utils")

function M.get(colors, separator, icons)
  local FileIcon = require("plugins.ui.heirline_config.components_statusline.FileIcon").get()
  local TablineFileName = require("plugins.ui.heirline_config.components_tabline.TablineFileName").get()
  local BufferCloseButton =
    require("plugins.ui.heirline_config.components_tabline.BufferCloseButton").get(colors, icons)
  local BufferCloseAllButton =
    require("plugins.ui.heirline_config.components_tabline.BufferCloseAllButton").get(colors, icons)
  local TablineFileFlags = require("plugins.ui.heirline_config.components_tabline.TablineFileFlags").get(colors, icons)
  local TabpageClose = require("plugins.ui.heirline_config.components_tabline.TabpageClose").get(colors, icons)

  local buflist_cache = {}

  local get_bufs = function()
    return vim.tbl_filter(function(bufnr)
      return vim.api.nvim_get_option_value("buflisted", { buf = bufnr })
    end, vim.api.nvim_list_bufs())
  end

  local TablineFileNameBlock = {
    init = function(self)
      self.filename = vim.api.nvim_buf_get_name(self.bufnr)
    end,
    hl = function(self)
      if self.is_active then
        return { fg = colors.fg, bg = colors.gray1 }
      else
        return { fg = colors.subtext4, bg = colors.bg }
      end
    end,
    on_click = {
      callback = function(_, minwid, _, button)
        if button == "m" then -- close on mouse middle click
          vim.schedule(function()
            vim.api.nvim_buf_delete(minwid, { force = false })
          end)
        else
          vim.api.nvim_win_set_buf(0, minwid)
        end
      end,
      minwid = function(self)
        return self.bufnr
      end,
      name = "heirline_tabline_buffer_callback",
    },
    FileIcon,
    TablineFileName,
    TablineFileFlags,
  }

  local TablineBufferBlock = {
    {
      provider = separator.left,
      hl = function(self)
        if self.is_active then
          return { fg = colors.blue, bg = colors.gray1 }
        else
          return { fg = colors.subtext4, bg = colors.bg }
        end
      end,
    },
    TablineFileNameBlock,
    BufferCloseButton,
  }

  local BufferLine = utils.make_buflist(
    TablineBufferBlock,
    { provider = icons.ui.Left .. " ", hl = { fg = colors.subtext3 } }, -- left truncation
    { provider = " " .. icons.ui.Right, hl = { fg = colors.subtext3 } }, -- right trunctation
    function()
      return buflist_cache
    end,
    -- no cache, as we're handling everything ourselves
    false
  )

  local Tabpage = {
    provider = function(self)
      return "%" .. self.tabnr .. "T " .. self.tabpage .. " %T"
    end,
    hl = function(self)
      if not self.is_active then
        return { fg = colors.subtext4, bg = colors.gray1 }
      else
        return { fg = colors.bg_dark, bg = colors.blue }
      end
    end,
    TabpageClose,
  }

  local TabPages = {
    condition = function()
      return #vim.api.nvim_list_tabpages() >= 2
    end,
    { provider = "%=" },
    utils.make_tablist(Tabpage),
  }
  local TabLineOffset = {
    condition = function(self)
      local win = vim.api.nvim_tabpage_list_wins(0)[1]
      local bufnr = vim.api.nvim_win_get_buf(win)
      self.winid = win

      if vim.bo[bufnr].filetype == "NvimTree" then
        self.title = "NvimTree"
        return true
      end
    end,

    provider = function(self)
      local title = self.title
      local width = vim.api.nvim_win_get_width(self.winid)
      local pad = math.ceil((width - #title) / 2)
      return string.rep(" ", pad) .. title .. string.rep(" ", pad)
    end,

    hl = function(self)
      if vim.api.nvim_get_current_win() == self.winid then
        return "TablineSel"
      else
        return "Tabline"
      end
    end,
  }

  local TabLine = {
    TabLineOffset,
    BufferLine,
    { provider = "%=" },
    TabPages,
    BufferCloseAllButton,
    hl = { bg = colors.bg_dark },
  }

  vim.api.nvim_create_autocmd({ "VimEnter", "UIEnter", "BufAdd", "BufDelete" }, {
    callback = function()
      vim.schedule(function()
        local buffers = get_bufs()
        for i, v in ipairs(buffers) do
          buflist_cache[i] = v
        end
        for i = #buffers + 1, #buflist_cache do
          buflist_cache[i] = nil
        end

        if #buflist_cache > 1 then
          vim.o.showtabline = 2
        elseif vim.o.showtabline ~= 1 then
          vim.o.showtabline = 1
        end
      end)
    end,
  })

  return TabLine
end

return M
