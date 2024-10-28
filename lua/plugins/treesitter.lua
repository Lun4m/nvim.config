-- Defer Treesitter setup after first render to improve startup time

return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        sync_install = false,
        modules = {},
        ignore_install = {},
        ensure_installed = {
          "bash",
          "c",
          "cpp",
          "dockerfile",
          "go",
          "html",
          "javascript",
          "json",
          "just",
          "latex",
          "lua",
          "python",
          "rust",
          "sql",
          "toml",
          "tsx",
          "typescript",
          "vim",
          -- "vimdoc",
        },
        auto_install = false,
        highlight = { enable = true, disable = { "dotenv" } },
        -- TODO: check all these options
        indent = { enable = true },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<c-space>",
            node_incremental = "<c-space>",
            scope_incremental = "<c-s>",
            node_decremental = "<M-space>",
          },
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ["aa"] = "@parameter.outer",
              ["ia"] = "@parameter.inner",
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
            },
          },
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              ["]m"] = "@function.outer",
              ["]]"] = "@class.outer",
            },
            goto_previous_start = {
              ["[m"] = "@function.outer",
              ["[["] = "@class.outer",
            },
            goto_next_end = {
              ["]M"] = "@function.outer",
              ["]["] = "@class.outer",
            },
            goto_previous_end = {
              ["[M"] = "@function.outer",
              ["[]"] = "@class.outer",
            },
          },
          -- No idea what this does :)
          swap = {
            enable = true,
            swap_next = {
              ["<leader>a"] = "@parameter.inner",
            },
            swap_previous = {
              ["<leader>A"] = "@parameter.inner",
            },
          },
        },
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    opts = {
      max_lines = 1,
      trim_scope = "inner",
    },
    config = function(_, opts)
      vim.keymap.set("n", "[c", function()
        require("treesitter-context").go_to_context(vim.v.count1)
      end, { silent = true, desc = "Goto previous TS-context" })

      require("treesitter-context").setup(opts)
    end,
  },
}
