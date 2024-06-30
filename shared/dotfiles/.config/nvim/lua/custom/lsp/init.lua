local lspconfig_ok, lspconfig = pcall(require, 'lspconfig')
local lsp_capabilities = require('custom.lsp.capabilities')
local automatic_setup_servers = require('custom.lsp.mason')

-- Disable LSP watcher - Too slow on linux
-- TODO: Remove this https://github.com/neovim/neovim/issues/23291
local lsp_wf_ok, lsp_wf = pcall(require, 'vim.lsp._watchfiles')
if lsp_wf_ok then
   lsp_wf._watchfunc = function()
     return function() end
   end
end

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
