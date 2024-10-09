return {
  "nvimdev/lspsaga.nvim",
  event = "LspAttach",
  enabled = false,
  opts = {
    preview = {
      lines_above = 1,
      lines_below = 12,
    },
    scroll_preview = {
      scroll_down = "<C-j>",
      scroll_up = "<C-k>",
    },
    request_timeout = 3000,
    finder = {
      keys = {
        jump_to = "e",
        edit = { "o", "<CR>" },
        quit = { "q", "<ESC>" },
        close_in_preview = "<ESC>",
      },
    },
    definition = {
      split = "<C-c>s",
      tabe = "<C-c>t",
      quit = "q",
      close = "<Esc>",
    },
    lightbulb = {
      enable = false,
      enable_in_insert = true,
      sign_priority = 20,
    },
    diagnostic = {
      on_insert = false,
      on_insert_follow = false,
      show_source = true,
      jump_num_shortcut = true,
      keys = {
        exec_action = "<CR>",
        quit = "q",
        go_action = "g",
      },
    },
    rename = {
      quit = "<C-c>",
      mark = "x",
      confirm = "<CR>",
      exec = "<CR>",
      in_select = true,
    },
    outline = {
      auto_preview = false,
      keys = {
        jump = "<CR>",
        expand_collapse = "u",
        quit = "q",
      },
    },
    symbol_in_winbar = {
      enable = false,
      show_file = false,
    },
    ui = {
      border = "rounded", -- Can be single, double, rounded, solid, shadow.
      winblend = 0,
    },
  },
}
