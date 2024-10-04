local M = {}
local conditions = require("heirline.conditions")

function M.get(colors, separator, icons)
  return {
    condition = conditions.is_git_repo,
    init = function(self)
      self.status_dict = vim.b.gitsigns_status_dict
      self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
    end,
    static = {
      git_branch_icon = icons.git.Branch,
      git_add_icon = icons.git.Add,
      git_remove_icon = icons.git.Remove,
      git_change_icon = icons.git.Mod_alt,
    },

    {
      provider = separator.left,
      hl = { fg = colors.green, bg = colors.bg_dark },
    },
    {
      provider = function(self)
        return " " .. self.git_branch_icon .. self.status_dict.head .. " "
      end,
      hl = { bold = true },
    },
    {
      provider = separator.right,
      hl = function(self)
        local bg_color = colors.bg_dark
        if self.has_changes then
          bg_color = colors.gray2
        end
        return { fg = colors.green, bg = bg_color, bold = true }
      end,
    },
    {
      {
        provider = function(self)
          local count = self.status_dict.added or 0
          return count > 0 and (" " .. self.git_add_icon .. count)
        end,
        hl = { fg = colors.bright_green },
      },
      {
        provider = function(self)
          local count = self.status_dict.removed or 0
          return count > 0 and (" " .. self.git_remove_icon .. count)
        end,
        hl = { fg = colors.bright_orange },
      },
      {
        provider = function(self)
          local count = self.status_dict.changed or 0
          return count > 0 and (" " .. self.git_change_icon .. count)
        end,
        hl = { fg = colors.bright_yellow },
      },
      {
        condition = function(self)
          return self.has_changes
        end,
        provider = separator.right,
        hl = { fg = colors.gray2, bg = colors.bg_dark },
      },
      hl = { bg = colors.gray2 },
    },
    hl = { fg = colors.bg_dark, bg = colors.green },
  }
end

return M
