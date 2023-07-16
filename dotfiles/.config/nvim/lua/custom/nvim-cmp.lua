local setup, cmp = pcall(require, 'cmp')
if not setup then
  return
end

-- Completion
local function get_formatter()
  local lspkind_setup, lspkind = pcall(require, 'lspkind')
  if not lspkind_setup then
    return
  end

  return lspkind.cmp_format({
    mode = 'symbol',
    preset = 'default',
    maxwidth = 64,
    ellipsis_char = '...',
    menu = {
      buffer = '[BUF]',
      nvim_lsp = '[LSP]',
      nvim_lua = '[API]',
      path = '[PATH]',
      luasnip = '[SNIP]',
    },
  })
end

cmp.setup({
  formatting = {
    format = get_formatter(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-Space>'] = cmp.mapping.confirm({ select = true }),
    ['<C-u>'] = cmp.mapping.scroll_docs(-5),
    ['<C-d>'] = cmp.mapping.scroll_docs(5),
    ['<C-e>'] = cmp.mapping.abort(),
  }),
  snippet = {
    expand = function(args)
      vim.fn['vsnip#anonymous'](args.body)
    end,
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'nvim_lua' },
    { name = 'vsnip' },
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

-- Disable completion in command line window
-- due to a bug with popup window
vim.api.nvim_create_autocmd('CmdWinEnter', {
  callback = function()
    cmp.setup({ enabled = false })
  end
})

vim.api.nvim_create_autocmd('CmdWinLeave', {
  callback = function()
    cmp.setup({ enabled = true })
  end
})
