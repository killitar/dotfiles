return {
  "pmizio/typescript-tools.nvim",
  event = "BufReadPre",
  enabled = false,
  opts = {
    filetypes = {
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
      "vue",
    },
    settings = {
      tsserver_file_preferences = {
        includeInlayParameterNameHints = "literals",
        includeInlayVariableTypeHints = true,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayEnumMemberValueHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeCompletionsForModuleExports = true,
        quotePreference = "auto",
      },
      tsserver_plugins = {
        "@vue/typescript-plugin",
      },
    },
  },
}
