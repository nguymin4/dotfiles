local telescope_ok, telescope = pcall(require, 'telescope')
if not telescope_ok then
  return
end

local actions = require('telescope.actions')

telescope.setup({
  defaults = {
    mappings = {
      i = {
        ['<esc>'] = actions.close,
      },
    },
  },
  extensions = {
    ['ui-select'] = {
      require('telescope.themes').get_dropdown({})
    }
  },
  pickers = {
    find_files = {
      find_command = {
        'fd',
        '--hidden',
        '--type', 'f',
        '--color', 'never',
        '--exclude', '.git',
      }
    },
  }
})

telescope.load_extension('ui-select')
