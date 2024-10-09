return {
  "glepnir/dashboard-nvim",
  event = "VimEnter",
  opts = function()
    local logo = [[
███    ██ ██    ██ ██ ███    ███
████   ██ ██    ██ ██ ████  ████
██ ██  ██ ██    ██ ██ ██ ████ ██
██  ██ ██  ██  ██  ██ ██  ██  ██
██   ████   ████   ██ ██      ██
     ]]
    logo = string.rep("\n", 8) .. logo .. "\n"

    local header = vim.split(logo, "\n")
    local opts = {
      theme = "doom",
      hide = {
        statusline = false,
      },
      config = {
        header = header,
        center = {
          {
            action = "Telescope find_files",
            desc = " Find file",
            icon = "󰍉 ",
            key = "f",
          },
          {
            action = "Telescope projects",
            desc = " Find projects",
            icon = " ",
            key = "p",
          },
          {
            action = "Telescope oldfiles",
            desc = " Recent files",
            icon = "󱋡 ",
            key = "r",
          },
          {
            action = "Lazy",
            desc = " Plugins",
            icon = "󰒲 ",
            key = "l",
          },
          {
            action = "q",
            desc = " Quit",
            icon = "󰗼 ",
            key = "q",
          },
        },
        footer = function()
          local stats = require("lazy").stats()
          local ms = math.floor(math.floor(stats.startuptime * 100 + 0.5) / 100)
          local message = "  Loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. " ms"

          return {
            string.rep("─", 33),
            message,
            string.rep("─", 33),
          }
        end,
      },
    }

    for _, button in ipairs(opts.config.center) do
      button.desc = button.desc .. string.rep(" ", 26 - #button.desc)
      button.key_format = "  %s"
    end

    if vim.o.filetype == "lazy" then
      vim.cmd.close()
      vim.api.nvim_create_autocmd("User", {
        pattern = "DashboardLoaded",
        callback = function()
          require("lazy").show()
        end,
      })
    end

    return opts
  end,
}
