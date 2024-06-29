local lspconfig_ok, lspconfig = pcall(require, 'lspconfig')
local lsp_capabilities = require('custom.lsp.capabilities')
local automatic_setup_servers = require('custom.lsp.mason')

if not lspconfig_ok then
  return
end

-- LSP default settings
for _, server_name in ipairs(automatic_setup_servers) do
  lspconfig[server_name].setup({
    capabilities = lsp_capabilities
  })
end

-- LSP custom settings
require('custom.lsp.efmls')

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

-- Other modules
require('custom.lsp.actions')
require('custom.lsp.diagnostic')
