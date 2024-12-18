return {
  "rebelot/heirline.nvim",
  event = "UIEnter",
  enabled = false,
  config = function()
    local colors = require 'yugen.palette'
    local icons = {
      diagnostics = require("helpers.icons").get("diagnostics", true),
      git = require("helpers.icons").get("git", true),
      ui = require("helpers.icons").get("ui", true),
    }
    local separator_statusline = { left = "", right = "" }
    local separator_tabline = { left = "▏", right = "▕" }

    local StatusLines = require("plugins.ui.heirline_config.StatusLines").get(colors, separator_statusline, icons)
    local TabLine = require("plugins.ui.heirline_config.TabLine").get(colors, separator_tabline, icons)

    require("heirline").setup({
      statusline = StatusLines,
      tabline = TabLine,
    })
  end,
}
