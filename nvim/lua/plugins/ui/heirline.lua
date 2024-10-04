return {
  "rebelot/heirline.nvim",
  event = "UIEnter",
  config = function()
    local colors = require("obscure.palettes").get_palette("obscure")
    local icons = {
      diagnostics = require("helpers.icons").get("diagnostics", true),
      git = require("helpers.icons").get("git", true),
      ui = require("helpers.icons").get("ui", true),
    }
    local separator_statusline = { left = "", right = "" }

    local StatusLines = require("plugins.ui.heirline_config.StatusLines").get(colors, separator_statusline, icons)

    require("heirline").setup({
      statusline = StatusLines,
    })
  end,
}
