return {
  "OXY2DEV/markview.nvim",
  ft = { "markdown", "quarto", "rmd" },
  keys = {
    { "<leader>um", ft = { "markdown", "quarto", "rmd" }, "<cmd>Markview toggleAll<cr>", desc = "Render Markdown" },
  },
  config = function()
    local presets = require("markview.presets")

    require("markview").setup({
      headings = presets.headings.glow,
      checkboxes = presets.checkboxes.nerd,
      code_blocks = { sign = false },
    })
  end,
}
