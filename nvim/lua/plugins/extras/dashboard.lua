return {
  {
    "glepnir/dashboard-nvim",
    event = "VimEnter",
    enabled = true,
    dependencies = { { "nvim-tree/nvim-web-devicons" } },
    opts = function()
      local logo = [[
         ███    ██ ██    ██ ██ ███    ███
         ████   ██ ██    ██ ██ ████  ████
         ██ ██  ██ ██    ██ ██ ██ ████ ██
         ██  ██ ██  ██  ██  ██ ██  ██  ██
         ██   ████   ████   ██ ██      ██
     ]]
      logo = string.rep("\n", 3) .. logo .. "\n\n"

      local header = vim.split(logo, "\n")
      local header_greetin = "hello"
      local opts = {
        theme = "doom",
        hide = {
          statusline = false,
        },
        config = {
          header = header,
          center = {
            -- {
            --   action = "Telescope find_files",
            --   desc = " Find file",
            --   icon = "󰍉 ",
            --   key = "f",
            --   key_format = " %s",
            --   key_hl = "SpecialComment",
            -- },
            -- {
            --   action = "Telescope live_grep",
            --   desc = " Find text",
            --   icon = "󱎸 ",
            --   key = "F",
            --   key_format = " %s",
            --   key_hl = "SpecialComment",
            -- },
            {
              action = "ene | startinsert",
              desc = " New file",
              icon = " ",
              key = "n",
              key_format = " %s",
              key_hl = "SpecialComment",
            },
            {
              action = "Telescope projects",
              desc = " Find project",
              icon = " ",
              key = "p",
              key_format = " %s",
              key_hl = "SpecialComment",
            },
            {
              action = 'lua require("persistence").load()',
              desc = " Restore Session",
              icon = " ",
              key = "r",
              key_format = " %s",
              key_hl = "SpecialComment",
            },
            {
              action = "Lazy",
              desc = " Plugins",
              icon = "󰒲 ",
              key = "l",
              key_format = " %s",
              key_hl = "SpecialComment",
            },
            {
              action = "q",
              desc = " Quit",
              icon = "󰗼 ",
              key = "q",
              key_format = " %s",
              key_hl = "SpecialComment",
            },
          },
          footer = function()
            local stats = require("lazy").stats()
            local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)

            return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
          end,
        },
      }

      for _, button in ipairs(opts.config.center) do
        button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
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
  },
}
