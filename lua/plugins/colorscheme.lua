return {
  {
    "ellisonleao/gruvbox.nvim",
    opts = {
      undercurl = true,
      underline = true,
      bold = false,
      italic = {
        strings = true,
        comments = true,
        operators = false,
        folds = true,
      },
      strikethrough = true,
      invert_selection = false,
      invert_signs = false,
      invert_tabline = false,
      invert_intend_guides = false,
      inverse = true, -- invert background for search, diffs, statuslines and errors
      contrast = "soft", -- can be "hard", "soft" or empty string
      palette_overrides = {},
      overrides = {},
      dim_inactive = false,
      transparent_mode = false,
    },
    config = function()
      vim.o.background = "dark"
      vim.cmd.colorscheme("gruvbox")
    end,
  },
  -- {
  -- 	"eddyekofo94/gruvbox-flat.nvim",
  -- 	priority = 1000,
  -- 	enabled = true,
  -- 	config = function()
  --    vim.o.background = "dark"
  -- 		vim.g.gruvbox_flat_style = "hard"
  -- 		vim.g.gruvbox_transparent = false
  -- 		vim.g.gruvbox_dark_sidebar = { "neotree", "terminal" }
  -- 		vim.cmd.colorscheme("gruvbox-flat")
  -- 	end,
  -- },
  -- -- {
  -- 	"jgottzen/gruvbox-flat.nvim",
  -- 	priority = 1000,
  -- 	opts = {
  -- 		style = "dark",
  -- 		transparent = false,
  -- 		italics = {
  -- 			comments = true,
  -- 			keywords = true,
  -- 			functions = false,
  -- 			variables = false,
  -- 		},
  -- 		hide_inactive_statusline = false,
  -- 		-- colors = {},
  -- 		-- theme = {},
  -- 		dark_sidebar = true,
  -- 	},
  -- 	config = function()
  -- 		vim.o.background = "dark"
  -- 		vim.cmd.colorscheme("gruvbox-flat")
  -- 	end,
  -- },
}
