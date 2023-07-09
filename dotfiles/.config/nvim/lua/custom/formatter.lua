local formatter_setup, formatter = pcall(require, 'formatter')
if not formatter_setup then
  return
end

formatter.setup({
  filetype = {
    python = {
      require("formatter.filetypes.python").black,
    },
  }
})
