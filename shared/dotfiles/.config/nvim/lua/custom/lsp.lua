local lspconfig_ok, lspconfig = pcall(require, 'lspconfig')
if not lspconfig_ok then
  return
end

local cmp_nvim_lsp_ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if not cmp_nvim_lsp_ok then
  return
end

local mason_lspconfig_ok, mason_lspconfig = pcall(require, 'mason-lspconfig')
if not mason_lspconfig_ok then
  return
end

-- Disable LSP watcher - Too slow on linux
-- TODO: Remove this https://github.com/neovim/neovim/issues/23291
local lsp_wf_ok, lsp_wf = pcall(require, 'vim.lsp._watchfiles')
if lsp_wf_ok then
   lsp_wf._watchfunc = function()
     return function() end
   end
end

-- LSP default settings
local lsp_capabilities = cmp_nvim_lsp.default_capabilities()
for _, server_name in ipairs(mason_lspconfig.get_installed_servers()) do
  if server_name ~= 'pyright' then
    lspconfig[server_name].setup({
      capabilities = lsp_capabilities
    })
  end
end

-- LSP custom settings
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

-- EFM-langserver
local efmls_configs_ok, _ = pcall(require, 'efmls-configs.defaults')
local Job_ok, Job = pcall(require, 'plenary.job')

if efmls_configs_ok and Job_ok then
  -- Asynchronously check if a command is actually executable.
  -- The main reason for this complexity is due to pyenv using shims for ruff, black etc.
  function check_executable(command, callback)
    local ok, is_exe = pcall(vim.fn.executable, command)
    if not ok or 1 ~= is_exe then
      callback(command, false)
      return
    end

    Job:new({
      command = command,
      args = {'--version'},
      enable_handlers = false,
      on_exit = function(job, code)
        callback(command, code == 0)
      end
    }):start()
  end

  -- Given a list of commands, return only commands which are actually executable
  function check_executables(executables, callback)
    local remaining = #executables
    local commands = {}

    local check_cb = function(command, is_exe)
      if is_exe then
        table.insert(commands, command)
      end
      remaining = remaining - 1
      if remaining == 0 then
        callback(commands)
      end
    end

    for _, executable in pairs(executables) do
      check_executable(executable, check_cb)
    end
  end

  -- Run initial setup for EFM-langserver synchronously
  -- and asynchronously update it with language-specific configs
  -- This prevents issue that efm client can't be attached to buffer sometimes
  lspconfig.efm.setup({})

  function setup_efmls(filetypes)
    local efmls_languages = {}
    local finalize_setup = vim.schedule_wrap(function()
      local languages = {}
      for language, config_names in pairs(efmls_languages) do
        languages[language] = vim.iter(config_names):map(require):totable()
      end

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

    local remaining = #vim.tbl_keys(filetypes)
    for filetype, setup in pairs(filetypes) do
      check_executables(setup.commands, function(commands)
        efmls_languages[filetype] = setup.list_config_names(commands)
        remaining = remaining - 1
        if remaining == 0 then
          finalize_setup()
        end
      end)
    end
  end

  setup_efmls({
    python = {
      commands = { 'ruff', 'black', 'flake8', 'isort' },
      list_config_names = function(commands)
        local efmls_configs = {}
        for _, command in ipairs(commands) do
          -- If ruff exists, ignore all other tools
          if command == "ruff" then
            return {
              'efmls-configs.formatters.ruff',
              'efmls-configs.formatters.ruff_sort',
              'efmls-configs.linters.ruff',
            }
          end

          -- Otherwise, load other tools if available
          if command == "black" then
            table.insert(efmls_configs, 'efmls-configs.formatters.black')
          elseif command == "flake8" then
            table.insert(efmls_configs, 'efmls-configs.linters.flake8')
          elseif command == "isort" then
            table.insert(efmls_configs, 'efmls-configs.formatters.isort')
          end
        end
        return efmls_configs
      end
    }
  })
end

-- jdtls
if vim.fn.executable('jdtls') == 1 then
  lspconfig.jdtls.setup({
    capabilities = lsp_capabilities
  })
end

-- LSP function signature
local lsp_signature_ok, lsp_signature = pcall(require, 'lsp_signature')
if lsp_signature_ok then
  lsp_signature.setup({
    bind = true,
    fix_pos = true,
    hint_enable = false,
    handler_opts = {
      border = 'rounded',
    },
  })
  vim.api.nvim_set_hl(0, 'LspSignatureActiveParameter', {
    fg = '#a0c980',
    bg = 'NONE',
    ctermfg = 107,
    ctermbg = 'NONE',
  })
end

-- LSP actions
vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    local opts = { buffer = event.buf }

    vim.keymap.set('n', '<c-space>', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
    vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
    vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
    vim.keymap.set('n', 'ge', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
    vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)

    vim.keymap.set('n', '<leader>2', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
    vim.keymap.set('n', '<leader>f', '<cmd>lua vim.lsp.buf.format({ async = true })<cr>', opts)
    vim.keymap.set('n', '<leader>8', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)

    vim.keymap.set('n', 'gh', '<cmd>lua vim.diagnostic.open_float()<cr>', opts)
    vim.keymap.set('n', '[w', '<cmd>lua vim.diagnostic.goto_prev()<cr>', opts)
    vim.keymap.set('n', ']w', '<cmd>lua vim.diagnostic.goto_next()<cr>', opts)
  end
})

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = 'rounded'
})

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = 'rounded'
})

vim.api.nvim_create_user_command('LspWorkspaceAdd', function()
  vim.lsp.buf.add_workspace_folder()
end, { desc = 'Add folder to workspace' })

vim.api.nvim_create_user_command('LspWorkspaceList', function()
  vim.notify(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end, { desc = 'List workspace folders' })

vim.api.nvim_create_user_command('LspWorkspaceRemove', function()
  vim.lsp.buf.remove_workspace_folder()
end, { desc = 'Remove folder from workspace' })

-- Diagnostics
vim.diagnostic.config({
  float = {
    border = 'rounded'
  },
  severity_sort = true,
  virtual_text = false,
})

local trouble_ok, trouble = pcall(require, 'trouble')
if trouble_ok then
  trouble.setup({
    auto_preview = false,
    mode = 'document_diagnostics',
    signs = {
      error = 'E',
      warning = 'W',
      hint = 'H',
      information = 'I'
    },
  })
end
