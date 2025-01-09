-- Customize default nvim settings
require("config.options")

-- Load user-installed installed Luarocks packages
-- luarocks path configured to $HOME/.local
-- TODO: maybe use rocks.nvim instead
package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.local/share/lua/5.1/?/init.lua"
package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.local/share/lua/5.1/?.lua"

-- Set up virtualenv for neovim python integration
-- TODO: maybe we do not need this?
vim.g.python3_host_prog = vim.fn.expand("~/.venv/neovim/bin/python3")

-- Install package manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    -- plugins that don't need setup
    -- TODO: actually learn to use these two?
    -- Mostly rhubarb since git stuff is already handled well by lazygit
    "tpope/vim-fugitive",
    "tpope/vim-rhubarb",
    "felipec/vim-sanegx",
    -- TODO: remove when upgrading to 0.10
    -- and use `winfixbuf` instead?
    { "stevearc/stickybuf.nvim", opts = {} },

    { import = "plugins" },
  },

  -- lazy.nvim options
  ui = {
    border = "rounded",
  },
})

require("config.lsp")
require("config.format_lint_debug")
require("config.keymaps")
require("config.autocommands")
