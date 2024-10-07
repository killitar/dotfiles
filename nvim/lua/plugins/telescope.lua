return {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make", cond = vim.fn.executable("make") == 1 },
    "ahmedkhalf/project.nvim",
    "debugloop/telescope-undo.nvim",
  },
  keys = {
    {
      "<leader>,",
      "<cmd>Telescope scope buffers<cr>",
      desc = "Switch Buffer",
    },
    { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
    {
      "<leader>/",
      function()
        return require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
          previewer = false,
        }))
      end,
      desc = "Search in current buffer",
    },
    {
      "<leader><space>",
      "<cmd>Telescope find_files<cr>",
      desc = "Find files",
    },

    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
    { "<leader>fw", "<cmd>Telescope live_grep<cr>", desc = "Grep" },
    {
      "<leader>fa",
      "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<cr>",
      desc = "Find files all",
    },
    { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recently opened" },
    { "<leader>fb", "<cmd>Telescope scope buffers<cr>", desc = "Buffers" },

    { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
    { "<leader>sd", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics" },
    { "<leader>sp", "<cmd>Telescope projects<cr>", desc = "Projects" },
    { "<leader>su", "<cmd>Telescope undo<cr>", desc = "Undo History" },
    { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
    { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "Commits" },
    { "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "Status" },
  },
  opts = function()
    local actions = require("telescope.actions")
    local telescope = require("telescope")
    local icons = require("helpers.icons").get("ui", true)
    return {
      defaults = {
        prompt_prefix = icons.Search,
        selection_caret = icons.Separator,
        layout_config = { prompt_position = "top" },
        path_display = { "filename_first" },
        sorting_strategy = "ascending",
        mappings = {
          i = {
            ["<C-u>"] = false,
            ["<C-d>"] = false,
          },
          n = {
            ["q"] = actions.close,
          },
        },
        extensions = {
          undo = {
            side_by_side = true,
            layout_strategy = "vertical",
            layout_config = {
              preview_height = 0.8,
            },
          },
        },
      },
      pickers = {
        diagnostics = {
          theme = "ivy",
          initial_mode = "normal",
        },
      },

      telescope.load_extension("fzf"),
      telescope.load_extension("projects"),
      telescope.load_extension("undo"),
      telescope.load_extension("scope"),
    }
  end,
}
