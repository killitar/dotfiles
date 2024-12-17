return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  init = function(plugin)
    require("lazy.core.loader").add_to_rtp(plugin)
    require("nvim-treesitter.query_predicates")
  end,
  cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
  opts = {
    highlight = { enable = true },
    indent = { enable = true },
    ensure_installed = {
      "lua",
      "vim",
      "vimdoc",
      "regex",
      "typescript",
      "tsx",
      "javascript",
      "css",
      "scss",
      "sql",
      "fish",
      "gitignore",
      "json",
      "yaml",
      "html",
      "markdown",
      "markdown_inline",
      "vue",
      "svelte",
      "astro",
      "prisma",
      "dockerfile",
    },
  },
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
  end,
}
