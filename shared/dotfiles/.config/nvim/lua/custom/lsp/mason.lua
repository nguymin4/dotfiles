local lspconfig_ok, lspconfig = pcall(require, 'lspconfig')
local mason_ok, mason = pcall(require, 'mason')
local mason_lspconfig_ok, mason_lspconfig = pcall(require, 'mason-lspconfig')

if not mason_ok or not mason_lspconfig_ok then
  return nil
end

local M = {}

local function setup_lsp(automatic_setup_servers, capabilities)
  if not lspconfig_ok then
    return
  end

  for _, server_name in ipairs(automatic_setup_servers) do
    lspconfig[server_name].setup({
      capabilities = lsp_capabilities
    })
  end
end

function M.setup(opts)
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
    ensure_installed = opts.ensure_installed,
  })

  local is_automatic_setup = function(server_name)
    return vim.iter(opts.manual_setup_servers):all(function(manual_setup_server)
      return server_name ~= manual_setup_server
    end)
  end

  local installed_servers = mason_lspconfig.get_installed_servers()
  local automatic_setup_servers = vim.iter(installed_servers):filter(is_automatic_setup):totable()
  setup_lsp(automatic_setup_servers, opts.capabilities)
end

return M
