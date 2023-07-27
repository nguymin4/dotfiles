-- nvim-lspconfig
local lspconfig_setup, lspconfig = pcall(require, 'lspconfig')
if not lspconfig_setup then
  return
end

local cmp_nvim_lsp_setup, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if not cmp_nvim_lsp_setup then
  return
end

local mason_lspconfig_setup, mason_lspconfig = pcall(require, 'mason-lspconfig')
if not mason_lspconfig_setup then
  return
end

-- LSP default settings
local lsp_capabilities = cmp_nvim_lsp.default_capabilities()
for _, server_name in ipairs(mason_lspconfig.get_installed_servers()) do
  if server_name ~= 'pyright' then
    lspconfig[server_name].setup({
      capabilities = lsp_capabilities
    })
  end
end

-- LSP custom settings
lspconfig.pyright.setup({
  capabilities = lsp_capabilities,
  settings = {
    python = {
      analysis = {
        autoImportCompletions = true,
        autoSearchPaths = true,
        diagnosticMode = 'openFilesOnly',
        typeCheckingMode = 'basic',
        useLibraryCodeForTypes = true,
      },
    },
  },
})

-- LSP function signature
local lsp_signature_setup, lsp_signature = pcall(require, 'lsp_signature')
if lsp_signature_setup then
  lsp_signature.setup({
    bind = true,
    hint_prefix = '',
    handler_opts = {
      border = 'rounded'
    }
  })
end

-- EFM-langserver
lspconfig.efm.setup({
  init_options = { documentFormatting = true },
  settings = {
    rootMarkers = { '.git/' },
    languages = {
      python = {
        {
          formatCommand = 'black -q -',
          formatStdin = true
        },
        {
          lintCommand = 'flake8 --stdin-display-name ${INPUT} -',
          lintStdin = true,
          lintIgnoreExitCode = true,
          lintFormats = { '%f:%l:%c: %m' },
          lintSource = 'flake8',
        },
      }
    }
  }
})

-- LSP actions
vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    local opts = { buffer = event.buf }

    vim.keymap.set('n', '<c-space>', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
    vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
    vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
    vim.keymap.set('n', 'ge', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
    vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)

    vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
    vim.keymap.set('n', '<leader>f', '<cmd>lua vim.lsp.buf.format({ async = true })<cr>', opts)
    vim.keymap.set('n', '<F8>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)

    vim.keymap.set('n', 'gh', '<cmd>lua vim.diagnostic.open_float()<cr>', opts)
    vim.keymap.set('n', '[w', '<cmd>lua vim.diagnostic.goto_prev()<cr>', opts)
    vim.keymap.set('n', ']w', '<cmd>lua vim.diagnostic.goto_next()<cr>', opts)
  end
})

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = 'rounded'
})

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = 'rounded'
})

vim.api.nvim_create_user_command('LspWorkspaceAdd', function()
  vim.lsp.buf.add_workspace_folder()
end, { desc = 'Add folder to workspace' })

vim.api.nvim_create_user_command('LspWorkspaceList', function()
  vim.notify(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end, { desc = 'List workspace folders' })

vim.api.nvim_create_user_command('LspWorkspaceRemove', function()
  vim.lsp.buf.remove_workspace_folder()
end, { desc = 'Remove folder from workspace' })

-- Diagnostics
vim.diagnostic.config({
  float = {
    border = 'rounded'
  },
  severity_sort = true,
  virtual_text = false,
})

local trouble_setup, trouble = pcall(require, 'trouble')
if trouble_setup then
  trouble.setup({
    auto_preview = false,
    mode = 'document_diagnostics',
    signs = {
      error = 'E',
      warning = 'W',
      hint = 'H',
      information = 'I'
    },
  })
end
