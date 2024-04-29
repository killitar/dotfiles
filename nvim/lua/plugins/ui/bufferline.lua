return {
  "akinsho/bufferline.nvim",
  event = { "BufReadPost", "BufAdd", "BufNewFile" },
  keys = {
    { "te",      "<cmd>:tabedit<cr>",            desc = "New Tab" },
    { "<Tab>",   "<cmd>BufferLineCycleNext<cr>", desc = "Tab next" },
    { "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", desc = "Tab prev" },
  },
  opts = {
    options = {
      mode = "tabs",
      always_show_bufferline = false,
      show_buffer_close_icons = false,
      show_close_icon = false,
      color_icons = true,
      indicator = { style = "icon", icon = "▎" },
      max_name_length = 100,
      max_prefix_length = 30, -- prefix used when a buffer is de-duplicated
    },
  }
}
