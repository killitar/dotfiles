local M = {}

function M.get(colors, icons)
  return {
    condition = function(self)
      return self.is_active
    end,
    static = {
      close_icon = icons.ui.Close_circle,
    },
    provider = function(self)
      return "%999X" .. self.close_icon .. "%X"
    end,
    hl = { fg = colors.bg_dark },
  }
end

return M
