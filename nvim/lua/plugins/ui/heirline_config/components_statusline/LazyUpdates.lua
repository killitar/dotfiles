local M = {}

function M.get(colors, separator)
  return {
    condition = function()
      local ok, lazy_status = pcall(require, "lazy.status")
      return ok and lazy_status.has_updates()
    end,
    on_click = {
      callback = function()
        vim.defer_fn(function()
          vim.cmd("Lazy")
        end, 100)
      end,
      name = "sl_lazy_click",
    },
    {
      provider = separator.left,
      hl = { fg = colors.cyan, bg = colors.bg_dark },
    },
    {
      provider = function()
        return " " .. require("lazy.status").updates() .. " "
      end,
    },

    {
      provider = separator.right,
      hl = { fg = colors.cyan, bg = colors.bg_dark },
    },
    hl = { fg = colors.bg_dark, bg = colors.cyan, bold = true },
  }
end

return M
