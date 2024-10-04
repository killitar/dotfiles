local M = {}

function M.get(colors, separator)
  return {
    {
      provider = separator.left,
      hl = { fg = colors.yellow, bg = colors.bg_dark },
    },
    {
      provider = " %c:%l ",
    },
    {
      provider = separator.right,
      hl = { fg = colors.yellow, bg = colors.bg_dark },
    },
    hl = { fg = colors.bg_dark, bg = colors.yellow },
  }
end

return M
