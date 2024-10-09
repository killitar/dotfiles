return {
  "echasnovski/mini.starter",
  event = "VimEnter",
  enabled = false,
  config = function()
    local starter = require("mini.starter")
    local stats = require("lazy").stats()

    local config = {
      evaluate_single = true,
      items = {
        { name = "Find file", action = "Telescope find_files", section = "Telescope" },
        { name = "Grep text", action = "Telescope live_grep", section = "Telescope" },
        { name = "Projects", action = "Telescope projects", section = "Telescope" },
        { name = "Recent files", action = "Telescope oldfiles", section = "Telescope" },
        { name = "Lazy", action = "Lazy", section = "Config" },
        { name = "Session restore", action = [[lua require('persistence').load()]], section = "Session" },
        { name = "New File", action = "ene | startinsert", section = "Built-in" },
        { name = "Quit", action = "qa", section = "Built-in" },
      },
      footer = "⚡ Neovim loaded " .. stats.count .. " plugins",
    }

    starter.setup(config)
  end,
}
