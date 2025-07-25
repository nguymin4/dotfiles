local telescope_ok, telescope = pcall(require, 'telescope')
if not telescope_ok then
  return
end

local actions = require('telescope.actions')
local builtin = require('telescope.builtin')

telescope.setup({
  defaults = {
    mappings = {
      i = {
        ['<esc>'] = actions.close,
      },
    },
  },
  extensions = {
    live_grep_args = {
      additional_args = {'--hidden', '--glob=!.git/'}
    },
    ['ui-select'] = {
      require('telescope.themes').get_dropdown({})
    },
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
    grep_string = {
      additional_args = {'--hidden', '--glob=!.git/'}
    },
    live_grep = {
      additional_args = {'--hidden', '--glob=!.git/'}
    },
  }
})

local live_grep_args_ok, _ = pcall(telescope.load_extension, 'live_grep_args')
if live_grep_args_ok then
  local live_grep_args_shortcuts = require('telescope-live-grep-args.shortcuts')
  vim.keymap.set('n', '<leader>gs', telescope.extensions.live_grep_args.live_grep_args)
  vim.keymap.set('n', '<leader>gc', live_grep_args_shortcuts.grep_word_under_cursor)
  vim.keymap.set('v', '<leader>gc', live_grep_args_shortcuts.grep_visual_selection)
else
  vim.keymap.set('n', '<leader>gs', builtin.live_grep)
  vim.keymap.set('n', '<leader>gc', builtin.grep_string)
  vim.keymap.set('v', '<leader>gc', builtin.grep_string)
end

vim.keymap.set('n', '<leader>p', builtin.find_files, { desc = 'Find Files' })
vim.keymap.set('n', '<leader>b', builtin.buffers, { desc = 'List Buffers' })

pcall(telescope.load_extension, 'fzf')
pcall(telescope.load_extension, 'ui-select')
