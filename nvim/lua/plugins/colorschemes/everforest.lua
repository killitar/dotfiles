return {
  "neanias/everforest-nvim",
  enabled = false,
  config = function()
    require("everforest").setup({
      transparent_background_level = 1,
      on_highlights = function(hl, palette)
        hl.NormalFloat = { fg = palette.none, bg = palette.none, sp = palette.none }
        hl.FloatBorder = { fg = palette.none, bg = palette.none }
        hl.LazyNormal = { bg = palette.bg0 }
        hl.MasonNormal = { bg = palette.bg0 }
      end,
    })
  end,
}
