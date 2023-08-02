local telescope_ok, telescope = pcall(require, 'telescope')
if not telescope_ok then
  return
end

telescope.setup({
  extensions = {
    ['ui-select'] = {
      require('telescope.themes').get_dropdown({})
    }
  }
})

telescope.load_extension('ui-select')
