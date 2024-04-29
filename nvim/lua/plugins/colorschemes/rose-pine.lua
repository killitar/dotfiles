return {
  "rose-pine/neovim",
  enabled = false,
  name = "rose-pine",
  opts = {
    disable_float_background = true,
    disable_background = true,
    disable_italics = true,
    highlight_groups = {
      CursorLineNr = { bg = "overlay" },

      LazyNormal = { bg = "base" },
      MasonNormal = { bg = "base" },

      GitSignsAdd = { bg = "none" },
      GitSignsChange = { bg = "none" },
      GitSignsDelete = { bg = "none" },
    },
  },
}
