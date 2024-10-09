return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    {
      "williamboman/mason.nvim",
      cmd = "Mason",
      keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
      build = ":MasonUpdate",
    },
    { "smjonas/inc-rename.nvim", cmd = "IncRename", opts = {} },
    "williamboman/mason-lspconfig.nvim",
    -- "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    local icons = {
      ui = require("helpers.icons").get("ui", true),
      misc = require("helpers.icons").get("misc", true),
    }

    require("mason").setup({
      ui = {
        height = 0.8,
        icons = {
          package_pending = icons.ui.Modified_alt,
          package_installed = icons.ui.Check,
          package_uninstalled = icons.misc.Ghost,
        },
      },
    })
    local mason_lspconfig = require("mason-lspconfig")

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    -- capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

    local on_attach = function(client, bufnr)
      local lsp_map = require("helpers.keys").lsp_map

      lsp_map("<leader>cl", "<cmd>LspInfo<cr>", bufnr, "Lsp Info")
      lsp_map("gl", vim.diagnostic.open_float, bufnr, "Show line diagnostics")
      lsp_map("gK", "<cmd>lua vim.lsp.buf.signature_help()<CR>", bufnr, "Signature Help")
      lsp_map("gD", vim.lsp.buf.declaration, bufnr, "Goto Declaration")
      lsp_map("gd", function()
        require("telescope.builtin").lsp_definitions({ reuse_win = true })
      end, bufnr, "Go to definition")
      lsp_map("gI", function()
        require("telescope.builtin").lsp_implementations({ reuse_win = true })
      end, bufnr, "Goto Implementation")

      vim.keymap.set("n", "<leader>cr", function()
        return ":IncRename" .. " " .. vim.fn.expand("<cword")
      end, { expr = true, desc = "Rename" })
      lsp_map("<leader>ca", vim.lsp.buf.code_action, bufnr, "Code actions")

      if client.supports_method("textDocument/inlayHint") then
        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
      end

      if client.supports_method("textDocument/documentHighlight") then
        vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })
        vim.api.nvim_clear_autocmds({ buffer = bufnr, group = "lsp_document_highlight" })
        vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
          callback = function()
            vim.lsp.buf.document_highlight()
          end,
          buffer = bufnr,
          group = "lsp_document_highlight",
          desc = "Document Highlight",
        })
        vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
          callback = function()
            vim.lsp.buf.clear_references()
          end,
          buffer = bufnr,
          group = "lsp_document_highlight",
          desc = "Clear All the References",
        })
      end
    end

    local config = {
      virtual_text = true, -- false because used inline-diagnostic plugin
      update_in_insert = false,
      underline = true,
      severity_sort = true,
      float = {
        focusable = true,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
      },
    }
    vim.diagnostic.config(config)

    local servers = {
      pyright = {},
      volar = {},
      svelte = {},
      astro = {},
      html = {},
      emmet_language_server = {},
      cssls = {},
      unocss = {},
      tailwindcss = {},
      prismals = {},
    }

    mason_lspconfig.setup({
      ensure_installed = vim.tbl_keys(servers),
    })

    mason_lspconfig.setup_handlers({
      function(server_name)
        require("lspconfig")[server_name].setup({
          capabilities = capabilities,
          on_attach = on_attach,
        })
      end,
      ["vtsls"] = function()
        require("lspconfig").vtsls.setup({
          capabilities = capabilities,
          on_attach = on_attach,
          filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
          settings = {
            vtsls = {
              tsserver = {
                inlayHints = {
                  parameterNames = { enabled = "literals" },
                  parameterTypes = { enabled = true },
                  variableTypes = { enabled = true },
                  propertyDeclarationTypes = { enabled = true },
                  functionLikeReturnTypes = { enabled = true },
                  enumMemberValues = { enabled = true },
                },
                globalPlugins = {
                  {
                    name = "@vue/typescript-plugin",
                    location = require("mason-registry").get_package("vue-language-server"):get_install_path()
                      .. "/node_modules/@vue/language-server",
                    languages = { "vue" },
                    configNamespace = "typescript",
                    enableForWorkspaceTypeScriptVersions = true,
                  },
                },
              },
            },
          },
        })
      end,
    })
  end,
}
