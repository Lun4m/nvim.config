--  TODO: clean up this whole file
--
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(client, bufnr)
  local nmap = function(keys, func, desc)
    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
  end

  if client.server_capabilities.inlayHintProvider then
    vim.lsp.inlay_hint.enable(false)
    nmap("<leader>ch", function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
    end, "Toggle inlay hints")
  end

  if client.name == "rust-analyzer" then
    -- nmap("<leader>ca", "<cmd>RustLsp codeAction<cr>", "Code Action")
    nmap("<leader>cc", "<cmd>RustLsp openCargo<cr>", "Open Cargo.toml")
    nmap("J", "<cmd>RustLsp joinLines<cr>", "Join lines")
    -- nmap("<leader>ch", "<cmd>RustLsp view hir<cr>", "View HIR representation")
    nmap("<leader>cm", "<cmd>RustLsp view mir<cr>", "View MIR representation")
    nmap("<leader>ct", "<cmd>RustLsp testables<cr>", "Open Rust test selector")
  end

  if client.name == "crates.nvim" then
    local crates = require("crates")
    vim.keymap.set("n", "<leader>cc", crates.show_crate_popup, { desc = "Show crate info" })
    vim.keymap.set("n", "<leader>cf", crates.show_features_popup, { desc = "Show crate features" })
  end

  nmap("<leader>cr", vim.lsp.buf.rename, "Rename")
  nmap("<leader>ca", vim.lsp.buf.code_action, "Code Action")
  nmap("gd", require("telescope.builtin").lsp_definitions, "Goto definition")
  nmap("gr", require("telescope.builtin").lsp_references, "Goto references")
  nmap("gI", require("telescope.builtin").lsp_implementations, "Goto Implementation")
  nmap("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type Definition")
  nmap("<leader>cs", require("telescope.builtin").lsp_document_symbols, "Document Symbols")
  nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Workspace Symbols")

  nmap("K", vim.lsp.buf.hover, "Hover Documentation")
  nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

  -- Lesser used LSP functionality
  nmap("gD", vim.lsp.buf.declaration, "Goto Declaration")
  nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "Workspace add folder")
  nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "Workspace remove folder")
  nmap("<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, "Workspace list folders")

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
    vim.lsp.buf.format()
  end, { desc = "Format current buffer with LSP" })

  nmap("<leader>cx", "<cmd>FormatToggle<cr>", "Toggle format on save")
end

-- Signcolumn Diagnostic icons
for name, icon in pairs(require("config.icons").diagnostics) do
  local sign_name = "DiagnosticSign" .. name
  local hl_name = "Diagnostic" .. name
  vim.fn.sign_define(sign_name, { text = icon, texthl = hl_name, numhl = "" })
end

-- mason-lspconfig requires that these setup functions are called in this order
-- before setting up the eervers.
require("mason").setup({
  -- Activate this for testing
  -- registries = {
  --   "file:~/repos/mason-registry",
  -- },
  ui = { border = "rounded" },
})
-- require("mason-lspconfig").setup()

-- TODO: move to autocommands.lua
-- set file type for docker docker_compose_language_service
local function set_filetype(pattern, filetype)
  vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = pattern,
    command = "set filetype=" .. filetype,
  })
end

set_filetype({ "compose.*", "docker-compose.*" }, "yaml.docker-compose")

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
-- vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
--
vim.lsp.config("*", {
  -- capabilities = capabilities,
  on_attach = on_attach,
  root_markers = { ".git" },
})

vim.lsp.config("clangd", {
  cmd = {
    "clangd",
    "--all-scopes-completion",
    "--background-index",
    "--clang-tidy",
    "--compile_args_from=filesystem", -- lsp-> does not come from compie_commands.json
    "--completion-parse=always",
    "--completion-style=bundled",
    "--cross-file-rename",
    "--debug-origin",
    "--enable-config", -- clangd 11+ supports reading from .clangd configuration file
    "--fallback-style=Qt",
    "--folding-ranges",
    "--function-arg-placeholders",
    "--header-insertion=iwyu",
    "--pch-storage=memory", -- could also be disk
    "--suggest-missing-includes",
    "-j=4", -- number of workers
    "--log=error",
  },
  filetypes = { "c", "cpp", "objc", "objcpp", "h" },
  single_file_support = true,
  init_options = {
    compilationDatabasePath = vim.fn.getcwd() .. "/build",
  },
  capabilities = {
    offsetEncoding = { "utf-16" },
  },
})

vim.lsp.config("basedpyright", {
  filetypes = { "python" },
  settings = {
    basedpyright = {
      disableOrganizeImports = true,
      analysis = {
        -- Use ruff exclusively for lint
        -- ignore = { "*" },
        diagnosticSeverityOverrides = {
          reportUnknownMemberType = false,
        },
        typeCheckingMode = "standard",
      },
    },
  },
})

-- TODO: move to lazydev?
-- require("neodev").setup()
vim.lsp.config("lua_ls", {
  filetypes = { "lua" },
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
})

vim.lsp.config("rust-analyzer", {
  filetypes = { "rust" },
  on_attach = on_attach,
  capabilities = vim.lsp.protocol.make_client_capabilities(),
  default_settings = {
    ["rust-analyzer"] = {
      cargo = {
        features = "all",
        -- extraArgs = { "--nocapture" },
      },
      runnables = {
        extraTestBinaryArgs = { "--nocapture" },
      },
    },
  },
})

require("crates").setup({
  lsp = {
    on_attach = on_attach,
    enabled = true,
    actions = true,
    completion = true,
    hover = true,
  },
  completion = {
    crates = {
      enabled = true,
      max_results = 8,
      min_chars = 3,
    },
  },
  popup = {
    autofocus = true,
  },
})

vim.lsp.config("ruff", {
  filetypes = { "python" },
  init_options = {
    settings = {
      configuration = vim.fn.expand("$HOME") .. ".config/ruff/ruff.toml",
      lint = {
        ignore = { "F722" },
      },
    },
  },
})

vim.lsp.config("ansiblels", {
  settings = {
    redhat = {
      telemetry = {
        enabled = false,
      },
    },
    ansible = {
      validation = {
        lint = {
          enabled = true,
        },
      },
    },
  },
  filetypes = { "yaml.ansible" },
})

-- ["yamlls"] = function()
--   require("lspconfig").yamlls.setup({
--     settings = {
--       yaml = {
--         schemas = {
--           ["https://github.com/mason-org/registry-schema/releases/latest/download/package.schema.json"] = "*mason*.{yml,yaml}",
--           ["https://json.schemastore.org/github-workflow.json"] = ".github/workflows/*",
--           -- ["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/*.{yml,yaml}",
--           -- ["https://raw.githubusercontent.com/ansible/ansible-lint/main/src/ansiblelint/schemas/ansible-lint-config.json"] = "ansible/*",
--           -- ["https://json.schemastore.org/ansible-stable-2.9"] = "ansible/*",
--           ["https://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
--           -- ["https://json.schemastore.org/ansible-playbook"] = "*play*.{yml,yaml}",
--           ["https://json.schemastore.org/gitlab-ci"] = "*gitlab-ci*.{yml,yaml}",
--           -- kubernetes = "*.yaml",
--         },
--         customTags = {
--           "!vault scalar",
--         },
--       },
--     },
--     filetypes = { "yaml", "yaml.gitlab" },
--   })
-- end,

-- -- vim.lsp.config('lua_ls')
-- vim.api.nvim_create_autocmd("LspAttach", {
--   -- group = vim.api.nvim_create_augroup("my.lsp", {}),
--   callback = function(args)
--     local client = vim.lsp.get_client_by_id(args.data.client_id)
--     if not client then
--       return
--     end
--
--     if cl
--   end,
-- })

local servers = {
  "clangd",
  "bashls",
  "docker_compose_language_service",
  "dockerls",
  "gopls",
  "marksman",
  "ruff",
  "basedpyright",
  -- "rust_analyzer",
  -- "sqlls",
  "eslint",
  "ts_ls",
  "lua_ls",
  "ansiblels",
  "yamlls",
  -- ""
  -- html = { filetypes = { 'html', 'twig', 'hbs'} },
  -- TODO: not yet available in mason
  -- glasgow = {},
}

require("mason-lspconfig").setup({
  automatic_installation = true,
  ensure_installed = servers,
})

vim.lsp.enable(servers)
-- vim.lsp.enable("crates-nvim")

-- TODO: migrate to vim.lsp.config
require("lspconfig").glasgow.setup({})
-- postgrestools in mason
require("lspconfig").postgres_lsp.setup({})
