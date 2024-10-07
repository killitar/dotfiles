return {
  "echasnovski/mini.bufremove",
  event = { "BufReadPre", "BufNewFile" },
  keys = {
    {
      "<leader>bd",
      function()
        require("mini.bufremove").delete(0, false)
      end,
      desc = "Delete Buffer",
    },
    {
      "<leader>bo",
      function()
        local bufremove = require("mini.bufremove").delete
        local curr_buf = vim.api.nvim_get_current_buf()
        local buf_list = vim.api.nvim_list_bufs()
        local deleted_count = 0

        for _, bufnr in pairs(buf_list) do
          if bufnr ~= curr_buf then
            bufremove(bufnr, false)
            deleted_count = deleted_count + 1
          end
        end
        vim.notify("Removed " .. deleted_count .. " buffers")
      end,
      desc = "Delete other buffers ",
    },
  },
  opts = {},
}
