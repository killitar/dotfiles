local M = {}

function M.get()
  return {
    init = function(self)
      local filename = self.filename
      self.icon, self.icon_color = require("mini.icons").get("file", filename)
    end,
    provider = function(self)
      return self.icon and (self.icon .. " ")
    end,
    hl = function(self)
      return self.icon_color
    end,
  }
end

return M
