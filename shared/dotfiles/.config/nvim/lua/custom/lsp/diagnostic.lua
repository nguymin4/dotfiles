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
