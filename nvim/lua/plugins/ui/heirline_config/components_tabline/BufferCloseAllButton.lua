local M = {}

function M.get(colors, icons)
  return {
    static = {
      close_icon = icons.ui.Close,
    },
    {
      provider = function(self)
        return " " .. self.close_icon
      end,
      hl = { fg = colors.bg_dark, bg = colors.red },
      on_click = {
        callback = function()
          local bufremove = require("mini.bufremove").delete
          local curr_buf = vim.api.nvim_get_current_buf()
          local buf_list = vim.api.nvim_list_bufs()
          local deleted_count = 0
          vim.schedule(function()
            for _, bufnr in pairs(buf_list) do
              if bufnr ~= curr_buf then
                bufremove(bufnr, true)
                deleted_count = deleted_count + 1
              end
            end
            vim.notify("Removed " .. deleted_count .. " buffers")
            vim.cmd.redrawtabline()
          end)
        end,

        name = "heirline_tabline_close_all_buffer_callback",
      },
    },
  }
end

return M
