local M = {}

function M.get(colors, separator)
  return {
    init = function(self)
      self.filename = vim.api.nvim_buf_get_name(0)
    end,
    {
      provider = separator.left,
      hl = { bg = colors.bg_dark, fg = colors.blue },
    },
    {
      provider = function(self)
        local filename = vim.fn.fnamemodify(self.filename, ":t:r")
        if filename == "" then
          return " [No Name] "
        end
        return (" %s "):format(filename)
      end,
    },
    {
      provider = separator.right,
      hl = function()
        local bg_color = colors.bg_dark
        if vim.bo.filetype ~= "" then
          bg_color = colors.gray2
        end
        return { fg = colors.blue, bg = bg_color }
      end,
    },
    hl = { fg = colors.bg_dark, bg = colors.blue, bold = true },
  }
end

return M
