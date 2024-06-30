local nvim_treesitter_ok, nvim_treesitter = pcall(require, 'nvim-treesitter.configs')
if not nvim_treesitter_ok then
  return
end

nvim_treesitter.setup({
  ensure_installed = {
    'c',
    'css',
    'go',
    'graphql',
    'html',
    'java',
    'javascript',
    'julia',
    'lua',
    'markdown',
    'markdown_inline',
    'matlab',
    'python',
    'query',
    'scala',
    'scss',
    'sql',
    'terraform',
    'typescript',
    'vim',
    'vimdoc',
    'yaml',
    'zig',
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
})
