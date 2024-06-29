local mason_ok, mason = pcall(require, 'mason')
local mason_lspconfig_ok, mason_lspconfig = pcall(require, 'mason-lspconfig')

if not mason_ok or not mason_lspconfig_ok then
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
    'efm',
    'eslint',
    'golangci_lint_ls',
    'gopls',
    'html',
    'jdtls',
    'jsonls',
    'julials',
    'pyright',
    'terraformls',
    'tsserver',
    'yamlls',
    'zls',
  },
})

local manual_setup_servers = {
  'efm',
  'pyright',
}

local is_automatic_setup = function(server_name)
  return vim.iter(manual_setup_servers):all(function(manual_setup_server)
    return server_name ~= manual_setup_server
  end)
end

local installed_servers = mason_lspconfig.get_installed_servers()
local automatic_setup_servers = vim.iter(installed_servers):filter(is_automatic_setup):totable()
return automatic_setup_servers
