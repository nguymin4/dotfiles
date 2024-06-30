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
    'latex',
    'lua',
    'markdown',
    'markdown_inline',
    'matlab',
    'python',
    'query',
    'rust',
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
  textobjects = {
    select = {
      enable = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["ad"] = "@conditional.outer",
        ["id"] = "@conditional.inner",
        ["ao"] = "@loop.outer",
        ["io"] = "@loop.inner",
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
        ["]d"] = "@conditional.outer",
        ["]o"] = "@loop.outer",
        ["]a"] = "@parameter.outer",
        ["]c"] = "@class.outer"
      },
      goto_next_end = {
        ["]F"] = "@function.outer",
        ["]D"] = "@conditional.outer",
        ["]O"] = "@loop.outer",
        ["]A"] = "@parameter.outer",
        ["]C"] = "@class.outer",
      },
      goto_previous_start = {
        ["[f"] = "@function.outer",
        ["[d"] = "@conditional.outer",
        ["[o"] = "@loop.outer",
        ["[a"] = "@parameter.outer",
        ["[c"] = "@class.outer",
      },
      goto_previous_end = {
        ["[F"] = "@function.outer",
        ["[D"] = "@conditional.outer",
        ["[O"] = "@loop.outer",
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
