local lspconfig_ok, lspconfig = pcall(require, 'lspconfig')
local lsp_capabilities = require('custom.lsp.capabilities')
local mason_installed_servers = require('custom.lsp.mason')

if not lspconfig_ok then
  return
end

-- LSP default settings
for _, server_name in ipairs(mason_installed_servers) do
  if server_name ~= 'pyright' then
    lspconfig[server_name].setup({
      capabilities = lsp_capabilities
    })
  end
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

if vim.fn.executable('jdtls') == 1 then
  lspconfig.jdtls.setup({
    capabilities = lsp_capabilities
  })
end

-- Other modules
require('custom.lsp.actions')
require('custom.lsp.diagnostic')
