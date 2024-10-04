local M = {}

function M.get(colors, separator)
  return {
    condition = function()
      return vim.bo.filetype ~= ""
    end,
    {
      provider = function()
        return (" %s "):format(string.lower(vim.bo.filetype))
      end,
    },
    {
      provider = separator.right,
      hl = { fg = colors.gray2, bg = colors.bg_dark },
    },
    hl = { fg = colors.blue, bg = colors.gray2, bold = true, italic = true },
  }
end

return M
