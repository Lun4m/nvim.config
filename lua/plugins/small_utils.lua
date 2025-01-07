return {
  {
    "NStefan002/screenkey.nvim",
    lazy = false,
    version = "*", -- or branch = "dev", to use the latest commit
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
      jump = {
        autojump = true,
      },
      label = {
        uppercase = false,
      },
    },
    -- stylua: ignore
    keys = {
      { "s", mode = { "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-/>", mode = { "n" }, function() require("flash").jump() end, desc = "Flash search" },
    },
  },
  {
    {
      "3rd/image.nvim",
      opts = {},
    },
  },
  -- {
  --   rocks = {
  --     hererocks = true, -- recommended if you do not have global installation of Lua 5.1.
  --   },
  -- },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    opts = {
      completions = { lsp = { enabled = true } },
    },
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },
  {
    "saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    opts = {},
  },
  {
    "vladdoster/remember.nvim",
    config = function()
      require("remember")
    end,
  },
  {
    "echasnovski/mini.cursorword",
    event = "VeryLazy",
    opts = {},
  },
  {
    "echasnovski/mini.ai",
    event = "VeryLazy",
    opts = { n_lines = 500 },
  },
  {
    "echasnovski/mini.pairs",
    event = "VeryLazy",
    opts = {},
  },
  {
    "echasnovski/mini.surround",
    event = "VeryLazy",
    opts = {},
  },
  {
    "max397574/better-escape.nvim",
    opts = {
      default_mappings = false,
      mappings = {
        i = {
          j = {
            k = function()
              if vim.bo.filetype == "toggleterm" then
                return "<c-v>j<c-v>k"
              end
              return "<esc>"
            end,
          },
        },
      },
    },
  },
  {
    "ahmedkhalf/project.nvim",
    event = "VeryLazy",
    config = function()
      require("project_nvim").setup()
      require("telescope").load_extension("projects")
    end,
  },
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
      open_mapping = "<c-t>",
      close_on_exit = true,
      persist_mode = false,
      shade_terminals = false,
      -- direction = "float",
      float_opts = {
        border = "curved",
      },
    },
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      highlight = {
        keyword = "wide_fg",
        pattern = [[.*<((KEYWORDS)\s*(\([^\)]*\))?):]],
      },
    },
  },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      auto_preview = false,
    },
    keys = {
      { "<leader>tq", "<cmd>TodoQuickFix<cr>", desc = "Open quickfix list with all the TODOs" },
      { "<leader>td", "<cmd>Trouble diagnostics<cr>", desc = "Toggle Trouble for the current file" },
      { "<leader>tt", "<cmd>Trouble todo<cr>", desc = "Toggle TODOs for the current file" },
    },
  },
  {
    "laytan/cloak.nvim",
    opts = {},
    -- ft = { "dotenv" },
    -- keys = {
    --   { "<leader>cc", "<cmd>CloakToggle<cr>", desc = "Toggle cloak", ft = "dotenv" },
    -- },
  },
}
