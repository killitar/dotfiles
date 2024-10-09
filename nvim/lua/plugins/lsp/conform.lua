return {
  "stevearc/conform.nvim",
  event = "BufWritePre",
  cmd = "ConformInfo",
  keys = {
    {
      "<leader>cF",
      function()
        require("conform").format({ async = true })
      end,
      mode = "n",
      desc = "Format buffer",
    },
  },
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "isort", "black", stop_after_first = true },
      javascript = { "eslint_d", "prettierd", "prettier", stop_after_first = true },
      javascriptreact = { "eslint_d", "prettierd", "prettier", stop_after_first = true },
      typescript = { "eslint_d", "prettierd", "prettier", stop_after_first = true },
      typescriptreact = { "eslint_d", "prettierd", "prettier", stop_after_first = true },
      vue = { "eslint_d", "prettierd", "prettier", stop_after_first = true },
      svelte = { "eslint_d", "prettierd", "prettier", stop_after_first = true },
      astro = { "eslint_d", "prettierd", "prettier", stop_after_first = true },
      css = { "prettierd", "prettier", stop_after_first = true },
      scss = { "prettierd", "prettier", stop_after_first = true },
      less = { "prettierd", "prettier", stop_after_first = true },
      html = { "eslint_d", "prettierd", "prettier", stop_after_first = true },
      json = { "prettierd", "prettier", stop_after_first = true },
      jsonc = { "prettierd", "prettier", stop_after_first = true },
      yaml = { "prettierd", "prettier", stop_after_first = true },
      markdown = { "prettierd", "prettier", "markdownlint", "markdown-toc", stop_after_first = true },
      graphql = { "eslint_d", "prettierd", "prettier", stop_after_first = true },
      handlers = { "prettierd", "prettier", stop_after_first = true },

      ["_"] = { "trim_whitespace" },
    },
    format_after_save = {
      lsp_format = "fallback",
    },

    log_level = vim.log.levels.ERROR,
    notify_on_error = true,
  },
}
