local nvim_treesitter_ok, nvim_treesitter = pcall(require, 'nvim-treesitter.configs')
if not nvim_treesitter_ok then
  return
end

nvim_treesitter.setup({
  ensure_installed = {
    'bash',
    'c',
    'css',
    'dockerfile',
    'go',
    'graphql',
    'html',
    'java',
    'javascript',
    'julia',
    'latex',
    'lua',
    'markdown',
    'markdown_inline',
    'matlab',
    'promql',
    'python',
    'query',
    'rust',
    'scala',
    'scss',
    'sql',
    'terraform',
    'typescript',
    'tsx',
    'vim',
    'vimdoc',
    'yaml',
    'zig',
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  textobjects = {
    select = {
      enable = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
    swap = {
      enable = true,
      swap_next = {
        [")f"] = "@function.outer",
        [")a"] = "@parameter.inner",
      },
      swap_previous = {
        ["(f"] = "@function.outer",
        ["(a"] = "@parameter.inner",
      },
    },
    move = {
      enable = true,
      goto_next_start = {
        ["]f"] = "@function.outer",
        ["]a"] = "@parameter.outer",
        ["]c"] = "@class.outer"
      },
      goto_next_end = {
        ["]F"] = "@function.outer",
        ["]A"] = "@parameter.outer",
        ["]C"] = "@class.outer",
      },
      goto_previous_start = {
        ["[f"] = "@function.outer",
        ["[a"] = "@parameter.outer",
        ["[c"] = "@class.outer",
      },
      goto_previous_end = {
        ["[F"] = "@function.outer",
        ["[A"] = "@parameter.outer",
        ["[C"] = "@class.outer",
      },
    },
  },
})

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
