return {
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
  },
  {
    "echasnovski/mini.comment",
    keys = {
      { "gcc", mode = { "n", "v" }, desc = "Comment toggle current line" },
      { "gc",  mode = { "n", "v" }, desc = "Comment toggle" },
    },
    opts = {
      options = {
        custom_commentstring = function()
          return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
        end,
      },
    },
  }

}
