return {
  {
    -- directly open ipynb files as quarto docuements
    -- and convert back behind the scenes
    'GCBallesteros/jupytext.nvim',
    opts = {
      custom_language_formatting = {
        python = {
          extension = 'qmd',
          style = 'quarto',
          force_ft = 'quarto',
        },
      },
    },
  },
  {
    "quarto-dev/quarto-nvim",
    dependencies = {
      "jmbuhr/otter.nvim",
      "nvim-treesitter/nvim-treesitter",
      "benlubas/molten-nvim",
    },
    opts = {
      debug = false,
      closePreviewOnExit = true,
      lspFeatures = {
        enabled = true,
        chunks = "curly",
        languages = { "r", "python", "julia", "bash", "html" },
        diagnostics = {
          enabled = true,
          triggers = { "BufWritePost" },
        },
        completion = {
          enabled = true,
        },
      },
      codeRunner = {
        enabled = true,
        default_method = "molten",
      },
    },
  },
  -- TODO: otter.nvim
  -- apparently it's broken if using both pyright and ruff
  -- https://github.com/jmbuhr/otter.nvim/issues/235
  -- {},
  {
    "benlubas/molten-nvim",
    version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
    dependencies = { "3rd/image.nvim" },
    build = ":UpdateRemotePlugins",
    init = function()
      -- check if we are using wsl
      local wsl = os.getenv("WSL_INTEROP")
      if wsl ~= nil then
        vim.g.molten_image_provider = "none"
        vim.g.molten_auto_image_popup = true
      else
        vim.g.molten_image_provider = "image.nvim"
        vim.g.molten_auto_image_popup = false
      end

      -- vim.g.molten_virt_text_output = true
      -- vim.g.molten_virt_text_max_lines = 40
      vim.g.molten_wrap_output = false
      vim.g.molten_auto_open_output = false
      vim.g.molten_enter_output_beahvior = "open_and_enter"
      vim.g.molten_use_border_highlights = true
    end,
  },
}
