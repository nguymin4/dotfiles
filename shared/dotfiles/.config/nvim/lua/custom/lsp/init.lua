local cmp_nvim_lsp_ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
local mason = require('custom.lsp.mason')
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

vim.lsp.config('*', {
  capabilities = cmp_nvim_lsp.default_capabilities()
})

mason.setup({
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
    'ts_ls',
    'yamlls',
    'zls',
  },
  automatic_enable = {
    exclude = {
      'efm',
    },
  }
})

-- ruff vs efm-langserver
local lsp_util = require('custom.lsp.util')
if not lsp_util then
  return
end

local function setup_efmls()
  local efmls = require('custom.lsp.efmls')
  if not efmls then
    return
  end

  efmls.generate_configs(function(languages)
    vim.lsp.config('efm', {
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
    vim.lsp.enable('efm')
  end)
end

lsp_util.check_executable(
  lsp_util.which('ruff'),
  vim.schedule_wrap(function(has_ruff)
    if not has_ruff then
      return setup_efmls()
    end
    vim.lsp.enable('ruff')
  end)
)
