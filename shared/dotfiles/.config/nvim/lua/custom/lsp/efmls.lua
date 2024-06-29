-- efm-langserver

local lspconfig_ok, lspconfig = pcall(require, 'lspconfig')
local efmls_configs_ok, _ = pcall(require, 'efmls-configs.defaults')
local Job_ok, Job = pcall(require, 'plenary.job')
local lsp_capabilities = require('custom.lsp.capabilities')

if not (lspconfig_ok and efmls_configs_ok and Job_ok) then
  return
end

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
lspconfig.efm.setup({
  filetypes = { 'python' }
})

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
