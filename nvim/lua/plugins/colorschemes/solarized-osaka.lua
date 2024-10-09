return {
  "craftzdog/solarized-osaka.nvim",
  priority = 1000,
  enabled = false,
  opts = {
    transparent = false,
    styles = {
      floats = "transparent",
    },
    on_highlights = function(hl, c)
      hl.LazyNormal = { bg = c.bg }
      hl.MasonNormal = { bg = c.bg }
      hl.TroubleNormal = { bg = c.bg }
      hl.Visual = { bg = c.base02, reverse = false }
    end,
  },
}
