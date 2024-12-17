return {
  "saghen/blink.cmp",
  lazy = false,
  dependencies = "rafamadriz/friendly-snippets",
  version = "v0.*",
  opts = {
    appearance = {
      nerd_font_variant = "normal",
    },
    keymap = { preset = "super-tab" },
    completion = {
      menu = {
        border = "rounded",
        draw = {
          columns = { { "label", gap = 1 }, { "kind_icon", "kind" } },
        },
      },
      documentation = {
        window = {
          border = "rounded",
        },
      },
      ghost_text = {
        enabled = true,
      },
    },
    accept = {
      create_undo_point = false,
      auto_brackets = { enabled = true },
    },
    trigger = { signature_help = { enabled = true } },
    signature = {
      window = {
        border = "rounded",
      },
    },
  },
}
