local lspconfig_ok, lspconfig = pcall(require, 'lspconfig')
if not lspconfig_ok then
  return
end

local cmp_nvim_lsp_ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if not cmp_nvim_lsp_ok then
  return
end

local mason_lspconfig_ok, mason_lspconfig = pcall(require, 'mason-lspconfig')
if not mason_lspconfig_ok then
  return
end

-- Disable LSP watcher - Too slow on linux
-- TODO: Remove this https://github.com/neovim/neovim/issues/23291
local lsp_wf_ok, lsp_wf = pcall(require, 'vim.lsp._watchfiles')
if lsp_wf_ok then
   lsp_wf._watchfunc = function()
     return function() end
   end
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

-- LSP function signature
local lsp_signature_ok, lsp_signature = pcall(require, 'lsp_signature')
if lsp_signature_ok then
  lsp_signature.setup({
    bind = true,
    hint_prefix = '',
    handler_opts = {
      border = 'rounded'
    }
  })
end

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

local trouble_ok, trouble = pcall(require, 'trouble')
if trouble_ok then
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
