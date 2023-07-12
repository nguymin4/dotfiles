local lspconfig_setup, telescope = pcall(require, 'telescope')
if not lspconfig_setup then
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
