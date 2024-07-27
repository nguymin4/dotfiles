local lspconfig_ok, lspconfig = pcall(require, 'lspconfig')
local cmp_nvim_lsp_ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
local mason = require('custom.lsp.mason')
local lsp_util = require('custom.lsp.util')
require('custom.lsp.actions')
require('custom.lsp.diagnostic')

-- Disable LSP watcher - Too slow on linux
-- TODO: Remove this https://github.com/neovim/neovim/issues/23291
local lsp_wf_ok, lsp_wf = pcall(require, 'vim.lsp._watchfiles')
if lsp_wf_ok then
   lsp_wf._watchfunc = function()
     return function() end
   end
end

-- Download and setup LSP servers
if not mason or not cmp_nvim_lsp_ok then
  return
end

local lsp_capabilities = cmp_nvim_lsp.default_capabilities()

mason.setup({
  capabilities = lsp_capabilities,
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
    'texlab',
    'tsserver',
    'yamlls',
    'zls',
  },
  manual_setup_servers = {
    'efm',
    'pyright',
  },
})

-- pyright
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
        -- Ignore all files for analysis to exclusively use Ruff for linting
        ignore = {'*'},
      },
    },
  },
})

-- ruff and efm-langserver
if not lsp_util then
  return
end

local function setup_efmls()
  local efmls = require('custom.lsp.efmls')
  if not efmls then
    return
  end

  efmls.generate_configs(function(languages)
    lspconfig.efm.setup({
      capabilities = lsp_capabilities,
      filetypes = vim.tbl_keys(languages),
      settings = {
        rootMarkers = { '.git/' },
        languages = languages,
      },
      init_options = {
        documentFormatting = true,
        documentRangeFormatting = true,
      },
    })
  end)
end

lsp_util.check_executable(
  lsp_util.pyenv_which('ruff'),
  vim.schedule_wrap(function(has_ruff)
    if not has_ruff then
      return setup_efmls()
    end

    lspconfig.ruff.setup({
      capabilities = lsp_capabilities,
      on_attach = function(client, bufnr)
        if client.name == 'ruff' then
          -- Disable hover in favor of Pyright
          client.server_capabilities.hoverProvider = false
        end
      end
    })
  end)
)
