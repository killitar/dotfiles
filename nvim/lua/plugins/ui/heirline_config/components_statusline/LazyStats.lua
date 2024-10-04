local M = {}

function M.get(colors, separator)
  return {
    condition = function()
      local ok, lazy = pcall(require, "lazy")
      return ok and lazy.stats()
    end,
    {
      provider = function()
        return " " .. "loaded:" .. require("lazy").stats().loaded .. "/" .. require("lazy").stats().count .. " "
      end,
    },

    {
      provider = separator.right,
      hl = { fg = colors.gray2, bg = colors.bg_dark },
    },
    hl = { fg = colors.purple, bg = colors.gray2, bold = true, italic = true },
  }
end

return M
