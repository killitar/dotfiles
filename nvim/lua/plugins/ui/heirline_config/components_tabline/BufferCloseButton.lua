local M = {}

function M.get(colors, icons)
  return {
    condition = function(self)
      return not vim.api.nvim_get_option_value("modified", { buf = self.bufnr })
    end,
    static = {
      close_icon = icons.ui.Close,
    },
    {
      provider = function(self)
        return " " .. self.close_icon
      end,
      hl = function(self)
        if self.is_active then
          return { fg = colors.red, bg = colors.gray1 }
        else
          return { fg = colors.subtext4, bg = colors.bg }
        end
      end,
      on_click = {
        callback = function(_, minwid)
          vim.schedule(function()
            require("mini.bufremove").delete(minwid, true)
            vim.cmd.redrawtabline()
          end)
        end,
        minwid = function(self)
          return self.bufnr
        end,
        name = "heirline_tabline_close_buffer_callback",
      },
    },
  }
end

return M
