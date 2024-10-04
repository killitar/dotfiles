local M = {}

function M.get(colors, separator)
  return {
    init = function(self)
      self.mode = vim.fn.mode(1)
    end,
    update = {
      "ModeChanged",
      pattern = "*:*",
      callback = vim.schedule_wrap(function()
        vim.cmd("redrawstatus")
      end),
    },
    static = {
      mode_names = {
        ["n"] = "NORMAL",
        ["no"] = "O-PENDING",
        ["nov"] = "O-PENDING",
        ["noV"] = "O-PENDING",
        ["no\22"] = "O-PENDING",
        ["niI"] = "NORMAL",
        ["niR"] = "NORMAL",
        ["niV"] = "NORMAL",
        ["nt"] = "NORMAL",
        ["ntT"] = "NORMAL",
        ["v"] = "VISUAL",
        ["vs"] = "VISUAL",
        ["V"] = "V-LINE",
        ["Vs"] = "V-LINE",
        ["\22"] = "V-BLOCK",
        ["\22s"] = "V-BLOCK",
        ["s"] = "SELECT",
        ["S"] = "S-LINE",
        ["\19"] = "S-BLOCK",
        ["i"] = "INSERT",
        ["ic"] = "INSERT",
        ["ix"] = "INSERT",
        ["R"] = "REPLACE",
        ["Rc"] = "REPLACE",
        ["Rx"] = "REPLACE",
        ["Rv"] = "V-REPLACE",
        ["Rvc"] = "V-REPLACE",
        ["Rvx"] = "V-REPLACE",
        ["c"] = "COMMAND",
        ["cv"] = "EX",
        ["ce"] = "EX",
        ["r"] = "REPLACE",
        ["rm"] = "MORE",
        ["r?"] = "CONFIRM",
        ["!"] = "SHELL",
        ["t"] = "TERMINAL",
      },

      mode_colors = {
        n = colors.red,
        i = colors.cyan,
        v = colors.purple,
        V = colors.red,
        ["\22"] = colors.purple,
        c = colors.yellow,
        cv = colors.red,
        ce = colors.red,
        no = colors.red,
        s = colors.yellow,
        S = colors.yellow,
        ["\19"] = colors.yellow,
        R = colors.green,
        Rv = colors.purple,
        r = colors.cyan,
        rm = colors.cyan,
        ["r?"] = colors.cyan,
        ["!"] = colors.red,
        t = colors.bright_red,
      },
    },
    {
      provider = separator.left,
      hl = function(self)
        local mode = self.mode:sub(1, 1)
        return { fg = self.mode_colors[mode], bg = colors.bg_dark }
      end,
    },
    {
      provider = function(self)
        return (" %s "):format(self.mode_names[self.mode])
      end,
    },

    {
      provider = separator.right,
      hl = function(self)
        local mode = self.mode:sub(1, 1)
        return { fg = self.mode_colors[mode], bg = colors.bg_dark }
      end,
    },

    hl = function(self)
      local mode = self.mode:sub(1, 1)
      return { fg = colors.bg_dark, bg = self.mode_colors[mode], bold = true }
    end,
  }
end

return M
