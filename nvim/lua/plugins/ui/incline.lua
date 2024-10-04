return {
  "b0o/incline.nvim",
  event = "BufReadPre",
  opts = function()
    local colors = require("obscure.palettes").get_palette("obscure")
    local separator = { left = "", right = "" }
    local mini_icons = require("mini.icons")

    return {
      highlight = {
        groups = {
          IncLineNormal = { guifg = colors.fg, guibg = colors.bg },
          IncLineNormalNC = { guifg = colors.gray3, guibg = colors.bg_dark },
        },
      },
      window = {
        margin = { vertical = 0, horizontal = 1 },
      },
      hide = {
        cursorline = true,
      },
      render = function(props)
        local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
        local icon, hl = mini_icons.get("file", filename)

        if vim.bo[props.buf].modified then
          filename = "[+]" .. filename
        end

        if props.focused then
          return {
            guibg = colors.gray2,
            { separator.left, guifg = colors.gray2, guibg = colors.bg },
            { icon, group = hl },
            { " " },
            { filename },
            { separator.right, guifg = colors.gray2, guibg = colors.bg },
          }
        else
          return {
            guibg = colors.gray1,
            { separator.left, guifg = colors.gray1, guibg = colors.bg_dark },
            { icon },
            { " " },
            { filename },
            { separator.right, guifg = colors.gray1, guibg = colors.bg_dark },
          }
        end
      end,
    }
  end,
}
