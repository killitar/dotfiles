return {
  "folke/tokyonight.nvim",
  lazy = false,
  enabled = false,
  config = function()
    require("tokyonight").setup({
      transparent = false,
      styles = {},
      on_highlights = function(hl, c)
        hl.LazyNormal = { bg = c.bg_dark }
        hl.MasonNormal = { bg = c.bg_dark }
      end,
    })
  end,
}
