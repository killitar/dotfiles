return {
  "nvim-neo-tree/neo-tree.nvim",
  enabled = false,
  cmd = "Neotree",
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  keys = {
    { "<leader>e", "<cmd>Neotree reveal focus toggle<cr>", { "n", "v" }, desc = "NeoTree" },
    { "<leader>o", "<cmd>Neotree git_status toggle<cr>", { "n", "v" }, desc = "NeoTree git status" },
    { "sf", "<cmd>Neotree reveal focus toggle<cr>", { "n", "v" }, desc = "NeoTree" },
  },
  opts = {
    popup_border_style = "rounded",
    auto_clean_after_session_restore = true,
    close_if_last_window = true,
    sources = { "filesystem", "buffers", "git_status" },
    window = {
      position = "float",
    },
    filesystem = {
      bind_to_cwd = false,
      follow_current_file = true,
      use_libuv_file_watcher = true,
    },
  },
}
