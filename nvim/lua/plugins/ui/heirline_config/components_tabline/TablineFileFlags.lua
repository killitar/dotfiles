local M = {}

function M.get(colors, icons)
  return {
    {
      condition = function(self)
        return vim.api.nvim_get_option_value("modified", { buf = self.bufnr })
      end,
      provider = " " .. icons.ui.Circle_alt,
      hl = { fg = colors.green },
    },
    {
      condition = function(self)
        return not vim.api.nvim_get_option_value("modifiable", { buf = self.bufnr })
          or vim.api.nvim_get_option_value("readonly", { buf = self.bufnr })
      end,
      provider = function(self)
        if vim.api.nvim_get_option_value("buftype", { buf = self.bufnr }) == "terminal" then
          return "   "
        else
          return ""
        end
      end,
      hl = { fg = colors.red },
    },
  }
end

return M
