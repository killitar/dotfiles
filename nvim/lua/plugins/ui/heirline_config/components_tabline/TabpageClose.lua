local M = {}

function M.get(colors, icons)
  return {
    static = {
      close_icon = icons.ui.Close,
    },
    provider = function(self)
      return "%999X" .. self.close_icon .. "%X"
    end,
    hl = { fg = colors.red },
  }
end

return M
