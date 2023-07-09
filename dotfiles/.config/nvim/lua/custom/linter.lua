-- Diagnostics
vim.diagnostic.config({
  severity_sort = true,
  virtual_text = false,
})

local lint_setup, lint = pcall(require, 'lint')
if not lint_setup then
  return
end

lint.linters_by_ft = {
  python = { 'flake8' },
}

vim.api.nvim_create_autocmd({ 'BufRead', 'BufWritePost' }, {
  callback = function()
    lint.try_lint()
  end,
})

local trouble_setup, trouble = pcall(require, 'trouble')
if not trouble_setup then
  return
end

trouble.setup({
  auto_preview = false,
  mode = 'document_diagnostics',
  signs = {
    error = "E",
    warning = "W",
    hint = "H",
    information = "I"
  },
})
