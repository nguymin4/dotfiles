local nvim_treesitter_ok, nvim_treesitter = pcall(require, 'nvim-treesitter')
if nvim_treesitter_ok then
  nvim_treesitter.install({
    'bash',
    'css',
    'dockerfile',
    'go',
    'graphql',
    'html',
    'java',
    'javascript',
    'julia',
    'latex',
    'matlab',
    'promql',
    'python',
    'rust',
    'scala',
    'scss',
    'sql',
    'terraform',
    'typescript',
    'tsx',
    'yaml',
    'zig',
  })

  local nvim_default_parsers = {
    'c',
    'lua',
    'markdown',
    'markdown_inline',
    'query',
    'vim',
    'vimdoc',
  }

  -- Automatically start treesitter for supported filetypes
  vim.api.nvim_create_autocmd('FileType', {
    callback = function(args)
      local lang = vim.treesitter.language.get_lang(args.match) or args.match
      local installed_parsers = nvim_treesitter.get_installed('parsers')
      if vim.tbl_contains(nvim_default_parsers, lang) or vim.tbl_contains(installed_parsers, lang) then
        -- syntax highlighting, provided by Neovim
        vim.treesitter.start(args.buf)
        -- folds, provided by Neovim
        vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        vim.wo.foldmethod = 'expr'
        -- indentation, provided by nvim-treesitter
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end
    end,
  })
end

-- indent-blankline
local ibl_ok, ibl = pcall(require, 'ibl')
if ibl_ok then
  ibl.setup({
    indent = {
      char = '┆',
    },
    scope = {
      enabled = false,
    },
    exclude = {
      filetypes = {
        'help',
        'startify',
        'fzf',
      }
    }
  })
end

-- nvim-ts-context-commentstring
local ts_context_commentstring_ok, ts_context_commentstring = pcall(require, 'ts_context_commentstring')
if ts_context_commentstring_ok then
  ts_context_commentstring.setup({
    enable_autocmd = false,
  })

  local vim_get_option = vim.filetype.get_option
  vim.filetype.get_option = function(filetype, option)
    return option == 'commentstring'
      and require('ts_context_commentstring.internal').calculate_commentstring()
      or vim_get_option(filetype, option)
  end
end
