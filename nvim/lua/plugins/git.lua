return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    keys = {
      {
        "<leader>ghp",
        "<cmd>Gitsigns preview_hunk<cr>",
        desc = "Preview Hunk",
      },
      {
        "<leader>ghb",
        "<cmd>Gitsigns blame_line<cr>",
        desc = "Blame Line",
      },
      {
        "<leader>ghB",
        "<cmd>Gitsigns blame<cr>",
        desc = "Blame Buffer",
      },
    },
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      signcolumn = true,
      watch_gitdir = { interval = 1000, follow_files = true },
      current_line_blame = false,
      current_line_blame_opts = { delay = 1000, virtual_text_pos = "eol" },
      current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
      sign_priority = 6,
      update_debounce = 100,
      status_formatter = nil, -- Use default
      word_diff = false,
      attach_to_untracked = true,
      diff_opts = { internal = true },
    },
  },
}
