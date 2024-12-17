local icons = {}

local data = {
  type = {
    Array = "󰅪",
    Boolean = "",
    Null = "󰟢",
    Number = "",
    Object = "󰅩",
    String = "󰉿",
  },
  documents = {
    Default = "",
    File = "",
    Files = "",
    FileTree = "󰙅",
    Import = "",
    Symlink = "",
  },
  git = {
    Add = "",
    Branch = "",
    Diff = "",
    Git = "󰊢",
    Ignore = "",
    Mod = "M",
    Mod_alt = "",
    Remove = "",
    Rename = "",
    Repo = "",
    Unmerged = "󰘬",
    Untracked = "󰞋",
    Unstaged = "",
    Staged = "",
    Conflict = "",
  },
  ui = {
    ArrowClosed = "",
    ArrowOpen = "",
    BigCircle = "",
    BigUnfilledCircle = "",
    BookMark = "󰃃",
    Bug = "",
    Calendar = "",
    Check = "󰄳",
    ChevronRight = "",
    Circle = "",
    Circle_alt = "",
    Close = "󰅖",
    Close_alt = "",
    Close_circle = "󰅙",
    CloudDownload = "",
    Comment = "󰅺",
    CodeAction = "󰌵",
    Dashboard = "",
    Emoji = "󰱫",
    EmptyFolder = "",
    EmptyFolderOpen = "",
    File = "󰈤",
    Fire = "",
    Folder = "",
    FolderOpen = "",
    Gear = "",
    History = "󰄉",
    Incoming = "󰏷",
    Indicator = "",
    Keyboard = "",
    Left = "",
    List = "",
    Square = "",
    SymlinkFolder = "",
    Lock = "󰍁",
    Modified = "✥",
    Modified_alt = "",
    NewFile = "",
    Newspaper = "",
    Note = "󰍨",
    Outgoing = "󰏻",
    Package = "",
    Pencil = "󰏫",
    Perf = "󰅒",
    Play = "",
    Project = "",
    Right = "",
    RootFolderOpened = "",
    Search = "󰍉 ",
    Separator = "",
    DoubleSeparator = "󰄾",
    SignIn = "",
    SignOut = "",
    Sort = "",
    Spell = "󰓆",
    Symlink = "",
    Table = "",
    Telescope = "",
  },
  diagnostics = {
    Error = "",
    Warning = "",
    Information = "",
    Question = "",
    Hint = "󰌵",
    -- Holo version
    Error_alt = "󰅚",
    Warning_alt = "󰀪",
    Information_alt = "",
    Question_alt = "",
    Hint_alt = "󰌶",
  },
  misc = {
    Campass = "󰀹",
    Code = "",
    EscapeST = "",
    Gavel = "",
    Glass = "󰂖",
    PyEnv = "󰌠",
    Squirrel = "",
    Tag = "",
    Tree = "",
    Watch = "",
    Lego = "",
    Vbar = "│",
    Add = "+",
    Added = "",
    Ghost = "󰊠",
    ManUp = "",
    Vim = "",
  },

  dap = {
    Breakpoint = "󰝥",
    BreakpointCondition = "󰟃",
    BreakpointRejected = "",
    LogPoint = "",
    Pause = "",
    Play = "",
    RunLast = "↻",
    StepBack = "",
    StepInto = "󰆹",
    StepOut = "󰆸",
    StepOver = "󰆷",
    Stopped = "",
    Terminate = "󰝤",
  },
}

---Get a specific icon set.
---@param category "kind"|"type"|"documents"|"git"|"ui"|"diagnostics"|"misc"|"cmp"|"dap"
---@param add_space? boolean @Add trailing space after the icon.
function icons.get(category, add_space)
  if add_space then
    return setmetatable({}, {
      __index = function(_, key)
        return data[category][key] .. " "
      end,
    })
  else
    return data[category]
  end
end

return icons
