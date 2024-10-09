return {
  "brenoprata10/nvim-highlight-colors",
  event = "BufReadPre",
  opts = {
    enable_tailwind = true,
    render = "virtual",
    virtual_symbol = "󱓻",
    exclude_filetypes = {
      "lazy",
      "mason",
      "lazyterm",
      "toggleterm",
      "TelescopeResults",
    },
  },
}
