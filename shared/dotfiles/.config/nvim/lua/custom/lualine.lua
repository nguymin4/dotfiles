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
    return 'auto', {}
  end

  local conf = vim.fn['edge#get_configuration']()
  local palette = vim.fn['edge#get_palette'](conf.style, conf.dim_foreground, conf.colors_override)

  local diagnostic_colors = {
    warn = { bg = palette.yellow[1], fg = palette.bg0[1] },
    error = { bg = palette.red[1], fg = palette.bg0[1] },
  }

  edge_theme['normal']['a'] = { bg = palette.filled_green[1], fg = palette.bg0[1], gui = 'bold' }
  edge_theme['command']['a'] = { bg = palette.filled_purple[1], fg = palette.bg0[1], gui = 'bold' }
  return edge_theme, diagnostic_colors
end

local function setup_lualine()
  local theme, diagnostic_colors = generate_theme()
  lualine.setup({
    options = {
      icons_enabled = true,
      theme = theme,
      disabled_filetypes = {
        statusline = { 'NvimTree' }
      },
    },
    sections = {
      lualine_a = { 'mode' },
      lualine_b = {
        {
          'branch',
          separator = { right = '' },
        },
        {
          'diff',
          icon = '',
          separator = { right = '' },
        },
        {
          'diagnostics',
          sources = { 'nvim_diagnostic' },
          sections = { 'warn' },
          diagnostics_color = {
            warn = diagnostic_colors['warn'],
          },
          separator = { right = '' },
        },
        {
          'diagnostics',
          sources = { 'nvim_diagnostic' },
          sections = { 'error' },
          diagnostics_color = {
            error = diagnostic_colors['error'],
          },
          separator = { right = '' },
        },
      },
      lualine_c = {
        {
          'filename',
          path = 3,
        }
      },
      lualine_x = { 'filetype', 'encoding', 'fileformat' },
      lualine_y = {
        {
          function()
            local space = vim.fn.search([[\s\+$]], 'nwc')
            return space ~= 0 and string.format('trailing[%s]', space) or ''
          end,
          icon = 'Ξ',
          color = diagnostic_colors['warn'],
        },
      },
      lualine_z = { 'progress', 'location' },
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
      lualine_z = { 'tabs' }
    },
    extensions = { 'aerial', 'mason', 'quickfix' }
  })
end

vim.api.nvim_create_autocmd('OptionSet', {
  pattern = 'background',
  callback = setup_lualine
})

setup_lualine()
