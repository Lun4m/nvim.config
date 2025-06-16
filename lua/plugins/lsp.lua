return {
  {
    "mrcjkb/rustaceanvim",
    ft = { "rust" },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      { "j-hui/fidget.nvim", tag = "legacy", opts = {} },
      "folke/neodev.nvim",
    },
    opts = { inlay_hints = { enabled = true } },
    config = function()
      require("lspconfig.ui.windows").default_options.border = "rounded"
    end,
  },
  {
    "jay-babu/mason-null-ls.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "nvimtools/none-ls.nvim",
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {},
  },
  {
    "mfussenegger/nvim-lint",
  },
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  -- {
  -- "b0o/schemastore.nvim",
  -- "mfussenegger/nvim-ansible",
  -- "Lun4m/nvim-ansible",
  -- },
}
