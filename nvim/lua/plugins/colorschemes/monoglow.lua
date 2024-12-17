return {
  "wnkz/monoglow.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    transparent = true,
    on_colors = function(colors)
      colors.glow = "#FFBE89"
    end,
    on_highlights = function(highlights, c)
      highlights.IndentBlanklineChar = { fg = c.comment, nocombine = true }
      highlights.IndentBlanklineContextChar = { fg = c.fg, nocombine = true }
      highlights.IblIndent = { fg = c.comment, nocombine = true }
      highlights.IblScope = { fg = c.fg, nocombine = true }
      highlights.IndentLine = { fg = c.syntax.comment, nocombine = true }
      highlights.IndentLineCurrent = { fg = c.fg, nocombine = true }
    end,
  },
}
