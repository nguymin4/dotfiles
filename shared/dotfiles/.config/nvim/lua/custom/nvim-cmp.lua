local cmp_ok, cmp = pcall(require, 'cmp')
if not cmp_ok then
  return
end

-- Completion menu
local function get_formatter()
  local lspkind_ok, lspkind = pcall(require, 'lspkind')
  if not lspkind_ok then
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

-- LSP function signature
local lsp_signature_ok, lsp_signature = pcall(require, 'lsp_signature')
if lsp_signature_ok then
  lsp_signature.setup({
    bind = true,
    fix_pos = true,
    hint_enable = false,
    handler_opts = {
      border = 'rounded',
    },
  })
  vim.api.nvim_set_hl(0, 'LspSignatureActiveParameter', {
    fg = '#a0c980',
    bg = 'NONE',
    ctermfg = 107,
    ctermbg = 'NONE',
  })
end

-- Completion
local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
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
    ['<C-j>'] = cmp.mapping(function(fallback)
      if vim.fn['vsnip#jumpable'](1) == 1 then
        feedkey('<Plug>(vsnip-jump-next)', '')
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<C-k>'] = cmp.mapping(function(fallback)
      if vim.fn['vsnip#jumpable'](-1) == 1 then
        feedkey('<Plug>(vsnip-jump-prev)', '')
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        if #cmp.get_entries() == 1 then
          cmp.confirm({ select = true })
        else
          cmp.select_next_item()
        end
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_prev_item()
      end
    end, { 'i', 's' }),
  }),
  snippet = {
    expand = function(args)
      vim.fn['vsnip#anonymous'](args.body)
    end,
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'nvim_lua' },
    {
      name = 'buffer',
      option = {
        get_bufnrs = function()
          return vim.api.nvim_list_bufs()
        end
      }
    },
    { name = 'vsnip' },
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
