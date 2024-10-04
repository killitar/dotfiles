local M = {}
local conditions = require("heirline.conditions")

function M.get(colors, separator)
  return {
    update = {
      "LspAttach",
      "LspDetach",
      "BufEnter",
      "DiagnosticChanged",
    },
    on_click = {
      callback = function()
        vim.defer_fn(function()
          vim.cmd("LspInfo")
        end, 100)
      end,
      name = "sl_lsp_click",
    },
    {
      provider = separator.left,
      hl = function()
        local bg_color = colors.bg_dark
        if conditions.has_diagnostics() then
          bg_color = colors.gray2
        end
        return { fg = colors.purple, bg = bg_color }
      end,
    },
    {
      provider = function()
        local bufnr = vim.api.nvim_get_current_buf()
        local buf_clients = vim.lsp.get_clients({ bufnr = bufnr })
        local buf_client_names = {}

        local hash = {}
        local unique_client_names = {}

        if next(buf_clients) == nil then
          return "   No servers "
        end

        for _, client in pairs(buf_clients) do
          if client.name ~= "null-ls" then
            table.insert(buf_client_names, client.name)
          end
        end

        for _, v in ipairs(buf_client_names) do
          if not hash[v] then
            unique_client_names[#unique_client_names + 1] = v
            hash[v] = true
          end
        end
        local language_servers = table.concat(unique_client_names, ", ")

        return "   " .. language_servers .. " "
      end,
    },
    {
      provider = separator.right,
      hl = { fg = colors.purple, bg = colors.bg_dark },
    },
    hl = { fg = colors.bg_dark, bg = colors.purple, bold = true, italic = true },
  }
end

return M
