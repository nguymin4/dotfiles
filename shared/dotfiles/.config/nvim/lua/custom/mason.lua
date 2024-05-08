local mason_ok, mason = pcall(require, 'mason')
if not mason_ok then
  return
end

local mason_lspconfig_ok, mason_lspconfig = pcall(require, 'mason-lspconfig')
if not mason_lspconfig_ok then
  return
end

mason.setup({
  ui = {
    border = 'rounded',
    icons = {
      package_installed = '✓',
      package_pending = '➜',
      package_uninstalled = '✗'
    }
  }
})

mason_lspconfig.setup({
  automatic_installation = false,
  ensure_installed = {
    'ansiblels',
    'bashls',
    'cssls',
    'eslint',
    'golangci_lint_ls',
    'gopls',
    'html',
    'jsonls',
    'julials',
    'pyright',
    'terraformls',
    'tsserver',
    'yamlls',
    'zls',
  },
})
