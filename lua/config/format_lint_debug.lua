-- Given the input tables, extract a list of all tools that need to be installed
---@param linters table<string, string[]>
---@param formatters table<string, string[]>
---@param debuggers table<string, string[]>
---@param ignore table<string, string[]>
---@return table
local function mason_autoinstall(linters, formatters, debuggers, ignore)
  local linter_list = vim.iter(vim.tbl_values(linters)):flatten():totable()
  local formatter_list = vim.iter(vim.tbl_values(formatters)):flatten():totable()
  local tools = vim.list_extend(linter_list, formatter_list)
  vim.list_extend(tools, debuggers)

  -- remove exceptions not to install
  tools = vim.tbl_filter(function(tool)
    return not vim.tbl_contains(ignore, tool)
  end, tools)
  return tools
end

local formatters = {
  go = { "gofmt" },
  html = { "prettier" },
  javascript = { "prettier" },
  lua = { "stylua" },
  python = { "ruff", "ruff_organize_imports", "ruff_format" },
  sh = { "shfmt", "shellcheck" },
  yaml = { "yamlfmt" },
  -- sql = { "sqlfmt" },
  -- typescript = { "biome" },
  -- json = { "biome" },
  -- jsonc = { "biome" },
  markdown = {
    "mdformat",
  },
  -- bib = { "trim_whitespace", "bibtex-tidy" },
  -- ["_"] = { "trim_whitespace", "trim_newlines", "squeeze_blanks" },
  -- ["*"] = { "codespell" },
}

local linters = { ansible = { "ansible-lint" }, systemd = { "systemdlint" } }
local debuggers = {}
local dont_install = {}
-- not real formatters, but pseudo-formatters from conform.nvim
-- {
-- "trim_whitespace",
-- "trim_newlines",
-- "squeeze_blanks",
-- "injected",
-- }

require("mason-null-ls").setup({
  ensure_installed = mason_autoinstall(linters, formatters, debuggers, dont_install),
  automatic_installation = false,
  handlers = {
    mdformat = function(name, methods)
      local installed = require("mason-null-ls").get_installed_sources()
      if vim.tbl_contains(installed, name) then
        return
      end

      require("mason-null-ls").default_setup(name, methods)

      local mdformat = require("mason-registry").get_package("mdformat")
      local plugins = {
        "mdformat-gfm",
        "mdformat-toc",
        "mdformat-tables",
        "mdformat-myst",
      }

      vim.notify("Installing mdformat extensions...")
      local python = mdformat:get_install_path() .. "/venv/bin/python"

      vim.system(
        { python, "-m", "pip", "install", unpack(plugins) },
        {},
        vim.schedule_wrap(function(res)
          if res.code == 0 then
            vim.notify("mdformat extensions were successfully installed.")
          else
            vim.notify("Could not install mdformat extensions: " .. res.stderr, vim.log.levels.ERROR)
          end
        end)
      )
    end,
  },
})

vim.g.format_is_enabled = true
vim.api.nvim_create_user_command("FormatToggle", function()
  vim.g.format_is_enabled = not vim.g.format_is_enabled
  print("Setting autoformatting to: " .. tostring(vim.g.format_is_enabled))
end, {
  desc = "Toggle autoformatting on save",
})

require("conform").setup({
  formatters_by_ft = formatters,
  format_on_save = function(_)
    if vim.g.format_is_enabled then
      return { timeout_ms = 500, lsp_fallback = true }
    end
  end,
})
