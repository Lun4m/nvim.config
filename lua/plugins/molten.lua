return {
  {
    "GCBallesteros/NotebookNavigator.nvim",
    keys = {
      {
        "<leader>jj",
        function()
          require("notebook-navigator").move_cell("d")
        end,
        desc = "Move cell up",
      },
      {
        "<leader>jk",
        function()
          require("notebook-navigator").move_cell("u")
        end,
        desc = "Move cell down",
      },
      {
        "<leader>jc",
        "<cmd>lua require('notebook-navigator').run_cell()<cr>",
        desc = "Run cell",
      },
      {
        "<leader>jp",
        "<cmd>MoltenInit<cr>",
        silent = true,
        noremap = true,
        desc = "Start Python kernel",
      },
    },
    -- { "<leader>x", "<cmd>lua require('notebook-navigator').run_and_move()<cr>" },
    dependencies = {
      "echasnovski/mini.comment",
      -- "hkupty/iron.nvim", -- repl provider
      -- "akinsho/toggleterm.nvim", -- alternative repl provider
      "benlubas/molten-nvim", -- alternative repl provider
      -- "anuvyklack/hydra.nvim",
    },
    event = "VeryLazy",
    opts = {
      cell_markers = {
        python = "##",
      },
      repl_provider = "molten",
      -- syntax_highlight = true,
    },
    -- config = function()
    --   local nn = require "notebook-navigator"
    --   nn.setup({ activate_hydra_keys = "<leader>h" })
    -- end,
  },
  {
    "benlubas/molten-nvim",
    version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
    dependencies = { "3rd/image.nvim" },
    build = ":UpdateRemotePlugins",
    init = function()
      vim.g.molten_image_provider = "image.nvim"
      vim.g.molten_virt_text_output = true
      vim.g.molten_virt_text_max_lines = 40
      vim.g.molten_wrap_output = false
      vim.g.molten_auto_open_output = false
    end,
  },
}
