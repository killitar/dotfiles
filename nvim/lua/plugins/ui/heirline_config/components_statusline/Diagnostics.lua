local M = {}
local conditions = require("heirline.conditions")

function M.get(colors, separator, icons)
  return {
    condition = conditions.has_diagnostics(),
    init = function(self)
      self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
      self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
      self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
      self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
    end,
    update = { "DiagnosticChanged", "BufEnter" },
    static = {
      error_icon = icons.diagnostics.Error_alt,
      warn_icon = icons.diagnostics.Warning_alt,
      info_icon = icons.diagnostics.Information_alt,
      hint_icon = icons.diagnostics.Hint_alt,
    },
    on_click = {
      callback = function()
        require("telescope.builtin").diagnostics({
          layout_strategy = "center",
          bufnr = 0,
        })
      end,
      name = "sl_diagnostics_click",
    },

    {
      {
        condition = conditions.has_diagnostics,
        provider = separator.left,
        hl = { fg = colors.gray2, bg = colors.bg_dark },
      },
      {
        provider = function(self)
          return self.errors > 0 and (self.error_icon .. self.errors .. " ")
        end,
        hl = { fg = colors.red },
      },
      {
        provider = function(self)
          return self.warnings > 0 and (self.warn_icon .. self.warnings .. " ")
        end,
        hl = { fg = colors.yellow },
      },
      {
        provider = function(self)
          return self.info > 0 and (self.info_icon .. self.info .. " ")
        end,
        hl = { fg = colors.purple },
      },
      {
        provider = function(self)
          return self.hints > 0 and (self.hint_icon .. self.hints .. " ")
        end,
        hl = { fg = colors.cyan },
      },
      hl = { fg = colors.bg_dark, bg = colors.gray2 },
    },
  }
end

return M
