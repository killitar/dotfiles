return {
  "saghen/blink.cmp",
  lazy = false,
  dependencies = "rafamadriz/friendly-snippets",
  version = "v0.*",
  opts = {
    nerd_font_variant = "normal",
    windows = {
      autocomplete = {
        border = "rounded",
        draw = "reversed",
      },
      documentation = {
        border = "rounded",
      },
      signature_help = {
        border = "rounded",
      },
    },
    accept = {
      create_undo_point = false,
      -- experimental auto-brackets support
      auto_brackets = { enabled = true },
    },

    -- experimental signature help support
    trigger = { signature_help = { enabled = true } },
  },
}
