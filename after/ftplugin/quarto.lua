-- Disable ruff LSP since it currently breaks stuff
print("disabling ruff")
vim.lsp.enable("ruff", false)
