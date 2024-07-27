-- efm-langserver
local efmls_configs_ok, _ = pcall(require, 'efmls-configs')
local lsp_util = require('custom.lsp.util')

if not efmls_configs_ok or not lsp_util then
  return nil
end

local M = {}

local filetypes = {
  python = {
    commands = vim.iter({ 'black', 'flake8', 'isort' }):map(lsp_util.pyenv_which):totable(),
    list_config_names = function(commands)
      local efmls_configs = {}
      for _, command in ipairs(commands) do
        -- Otherwise, load other tools if available
        if string.find(command, 'black') then
          table.insert(efmls_configs, 'efmls-configs.formatters.black')
        elseif string.find(command, 'flake8') then
          table.insert(efmls_configs, 'efmls-configs.linters.flake8')
        elseif string.find(command, 'isort') then
          table.insert(efmls_configs, 'efmls-configs.formatters.isort')
        end
      end
      return efmls_configs
    end
  }
}

function M.generate_configs(cb)
  local efmls_languages = {}

  local finalize_setup = vim.schedule_wrap(function()
    local languages = {}
    for language, config_names in pairs(efmls_languages) do
      local configs = vim.iter(config_names):map(require):totable()
      if #configs > 0 then
        languages[language] = configs
      end
    end

    -- Skip running efmls if there is nothing to setup
    if #vim.tbl_keys(languages) > 0 then
      cb(languages)
    end
  end)

  local remaining = #vim.tbl_keys(filetypes)
  for filetype, setup in pairs(filetypes) do
    lsp_util.check_executables(setup.commands, function(commands)
      efmls_languages[filetype] = setup.list_config_names(commands)
      remaining = remaining - 1
      if remaining == 0 then
        finalize_setup()
      end
    end)
  end
end

return M
