local mason_ok, mason = pcall(require, 'mason')
local mason_lspconfig_ok, mason_lspconfig = pcall(require, 'mason-lspconfig')

if not mason_ok or not mason_lspconfig_ok then
  return nil
end

local M = {}

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
    ensure_installed = opts.ensure_installed,
    automatic_installation = false,
    automatic_enable = false,
  })

  -- Default automatic_enable.exclude in mason-lspconfig is very slow
  -- Thus we will enable server manually
  local is_automatically_enabled = function(server_name)
    return vim.iter(opts.automatic_enable.exclude):all(function(excluded_server)
      return server_name ~= excluded_server
    end)
  end

  local installed_servers = mason_lspconfig.get_installed_servers()
  for _, server_name in ipairs(installed_servers) do
    if is_automatically_enabled(server_name) then
      vim.lsp.enable(server_name)
    end
  end
end

return M
