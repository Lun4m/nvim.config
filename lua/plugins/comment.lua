return {
  {
    "echasnovski/mini.comment",
    dependencies = {
      {
        "JoosepAlviste/nvim-ts-context-commentstring",
        opts = {
          config = {
            cpp = "// %s",
            h = "// %s",
            wgsl = "// %s",
          },
        },
      },
    },
    event = "VeryLazy",
    opts = {
      options = {
        custom_commentstring = function()
          return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
        end,
      },
      mappings = {
        comment_line = "<leader>/",
        comment_visual = "<leader>/",
      },
    },
  },
}
