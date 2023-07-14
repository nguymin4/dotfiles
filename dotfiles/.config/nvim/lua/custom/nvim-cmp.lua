local setup, cmp = pcall(require, 'cmp')
if not setup then
  return
end

local cmp_nvim_ultisnips_setup, cmp_nvim_ultisnips = pcall(require, 'cmp_nvim_ultisnips')
if not cmp_nvim_ultisnips_setup then
  return
end

-- Ultisnips
cmp_nvim_ultisnips.setup({})

-- Completion
cmp.setup({
  formatting = {
    fields = {'abbr', 'menu', 'kind'},
    format = function(entry, item)
      local short_name = {
        nvim_lsp = 'LSP',
        nvim_lua = 'NVIM'
      }

      local menu_name = short_name[entry.source.name] or entry.source.name
      item.menu = string.format('[%s]', menu_name)
      return item
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-Space>'] = cmp.mapping.confirm({ select = true }),
    ['<C-u>'] = cmp.mapping.scroll_docs(-5),
    ['<C-d>'] = cmp.mapping.scroll_docs(5),
    ['<C-e>'] = cmp.mapping.abort(),
  }),
  snippet = {
    expand = function(args)
      vim.fn['UltiSnips#Anon'](args.body)
    end,
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'nvim_lua' },
    { name = 'ultisnips' },
    {
      name = 'buffer',
      option = {
        get_bufnrs = function()
          return vim.api.nvim_list_bufs()
        end
      }
    },
    { name = 'path' },
  }),
  window = {
    completion = {
      border = 'rounded'
    },
    documentation = {
      border = 'rounded'
    },
  },
})
