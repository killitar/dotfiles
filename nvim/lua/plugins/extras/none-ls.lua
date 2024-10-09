return {
  "nvimtools/none-ls.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = { "mason.nvim" },
  config = function()
    local null_ls = require("null-ls")

    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

    local lsp_formatting = function(bufnr)
      vim.lsp.buf.format({
        filter = function(client)
          return client.name == "null-ls"
        end,
        bufnr = bufnr,
      })
    end
    null_ls.setup({
      diagnostics_format = "[#{s}] #{m}\n(#{c})",
      sources = {
        null_ls.builtins.formatting.prettierd.with({
          filetypes = {
            "html",
            "json",
            "svelte",
            "markdown",
            "css",
            "javascript",
            "typescript",
            "javascriptreact",
            "typescriptreact",
            "vue",
          },
        }),
        null_ls.builtins.formatting.black.with({ extra_args = { "--fast" } }),
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.diagnostics.eslint_d,
      },
      on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
          vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
              lsp_formatting(bufnr)
            end,
          })
        end
      end,
    })
    vim.api.nvim_create_user_command("DisableLspFormatting", function()
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = 0 })
    end, { nargs = 0 })
  end,
}
