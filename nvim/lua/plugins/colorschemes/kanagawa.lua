return {
  "rebelot/kanagawa.nvim",
  enabled = false,
  opts = {
    compile = false,
    transparent = true,
    keywordStyle = { italic = false },
    colors = {
      theme = {
        all = {
          ui = {
            bg_gutter = "none",
          },
        },
      },
    },
    overrides = function(colors)
      local theme = colors.theme
      return {
        EndOfBuffer = { fg = theme.ui.fg_dim },

        CursorLineNr = { bg = theme.ui.bg_m3 },

        Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency
        PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
        PmenuSbar = { bg = theme.ui.bg_m1 },
        PmenuThumb = { bg = theme.ui.bg_p2 },

        NormalFloat = { bg = "none" },
        FloatBorder = { bg = "none" },
        FloatTitle = { bg = "none" },

        NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

        LazyNormal = { bg = theme.ui.bg, fg = theme.ui.fg_dim },
        MasonNormal = { bg = theme.ui.bg, fg = theme.ui.fg_dim },

        TelescopePromptNormal = { bg = theme.ui.bg },
        TelescopeResultsNormal = { bg = theme.ui.bg },
        TelescopePreviewNormal = { bg = theme.ui.bg },

        BufferlineFileIcon = { bg = theme.ui.bg_m1 },
      }
    end,
  },
}
