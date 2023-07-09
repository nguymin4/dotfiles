local mason_setup, mason = pcall(require, 'mason')
if not mason_setup then
  return
end

local mason_lspconfig_setup, mason_lspconfig = pcall(require, 'mason-lspconfig')
if not mason_lspconfig_setup then
  return
end

mason.setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    }
  }
})

mason_lspconfig.setup({
  automatic_installation = true,
  ensure_installed = {
    'cssls',
    'eslint',
    'html',
    'jsonls',
    'julials',
    'pyright',
    'tsserver',
    'yamlls',
  },
})
