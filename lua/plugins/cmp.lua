return {
  {
    "saghen/blink.cmp",
    lazy = false,
    dependencies = {
      "L3MON4D3/LuaSnip",
      "rafamadriz/friendly-snippets",
    },
    -- use a release tag to download pre-built binaries
    -- version = false,
    -- Builiding requires rust nightly
    version = "1.*",
    -- build = "cargo build --release",
    opts = {
      keymap = {
        ["<C-e>"] = { "hide", "fallback" },
        -- TODO: this does not work well when
        -- you want to only insert a new line
        -- without selection an entry from the
        -- completion menu
        ["<CR>"] = { "select_and_accept", "fallback" },

        ["<Tab>"] = { "select_next", "fallback" },
        ["<S-Tab>"] = { "select_prev", "fallback" },

        ["<C-j>"] = { "snippet_forward", "fallback" },
        ["<C-k>"] = { "snippet_backward", "fallback" },

        ["<C-b>"] = { "scroll_documentation_up", "fallback" },
        ["<C-d>"] = { "scroll_documentation_down", "fallback" },
      },

      completion = {
        list = {
          selection = { preselect = false, auto_insert = true },
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 50,
        },
        -- ghost_text = { enabled = true },

        -- experimental auto-brackets support
        accept = {
          auto_brackets = { enabled = true },
        },
      },

      fuzzy = {
        implementation = "prefer_rust_with_warning",
      },

      -- experimental signature help support
      signature = { enabled = true },

      snippets = {
        expand = function(snippet)
          require("luasnip").lsp_expand(snippet)
        end,
        active = function(filter)
          if filter and filter.direction then
            return require("luasnip").jumpable(filter.direction)
          end
          return require("luasnip").in_snippet()
        end,
        jump = function(direction)
          require("luasnip").jump(direction)
        end,
      },

      sources = {
        default = { "lazydev", "lsp", "path", "snippets", "buffer" },
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            -- make lazydev completions top priority (see `:h blink.cmp`)
            score_offset = 100,
          },
        },
      },
    },
  },
}
