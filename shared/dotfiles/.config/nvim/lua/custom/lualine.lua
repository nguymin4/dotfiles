local lualine_ok, lualine = pcall(require, 'lualine')
if not lualine_ok then
  return
end

local modules = require('lualine_require').lazy_require({
  loader = 'lualine.utils.loader',
})

local function generate_theme()
  local ok, edge_theme = pcall(modules.loader.load_theme, 'edge')
  if not ok or not edge_theme then
    return 'auto'
  end

  local configuration = vim.fn['edge#get_configuration']()
  local palette = vim.fn['edge#get_palette'](configuration.style, configuration.dim_foreground, configuration.colors_override)

  edge_theme["normal"]["a"] = { bg = palette.bg_green[1], fg = palette.bg0[1], gui = 'bold' }
  return edge_theme
end

local function setup_lualine()
  lualine.setup({
    options = {
      icons_enabled = true,
      theme = generate_theme(),
      disabled_filetypes = {
        statusline = { "NvimTree" }
      },
    },
    sections = {
      lualine_a = {'mode'},
      lualine_b = {
        'branch',
        'diff',
        {
          'diagnostics',
          sources={'nvim_lsp', 'nvim_diagnostic', 'nvim_workspace_diagnostic'},
          sections = { 'error', 'warn' },
        }
      },
      lualine_c = {
        {
          'filename',
          path = 3,
        }
      },
      lualine_x = {'filetype'},
      lualine_y = {'encoding', 'fileformat'},
      lualine_z = {'progress', 'location'}
    },
    tabline = {
      lualine_a = {
        {
          'buffers',
          mode = 4,
          show_filename_only = false,
          max_length = vim.o.columns,
          filetype_names = {
            aerial = 'Aerial',
            NvimTree = 'NvimTree',
            startify = 'Startify',
          },
        }
      },
      lualine_z = {'tabs'}
    },
    extensions = {'aerial', 'mason', 'quickfix'}
  })
end

vim.api.nvim_create_autocmd('OptionSet', {
  pattern = 'background',
  callback = setup_lualine
})

setup_lualine()
