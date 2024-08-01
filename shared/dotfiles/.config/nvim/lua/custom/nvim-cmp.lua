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
  })
end

-- Completion
local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

cmp.setup({
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
  matching = {
    disallow_fuzzy_matching = false,
    disallow_fullfuzzy_matching = false,
    disallow_partial_fuzzy_matching = true,
    disallow_partial_matching = false,
    disallow_prefix_unmatching = false,
    disallow_symbol_nonprefix_matching = true,
  },
  sorting = {
    priority_weight = 2,
    comparators = {
      cmp.config.compare.offset,
      cmp.config.compare.scopes,
      cmp.config.compare.exact,
      cmp.config.compare.score,
      function(entry1, entry2)
        local _, entry1_under = entry1.completion_item.label:find "^_+"
        local _, entry2_under = entry2.completion_item.label:find "^_+"
        entry1_under = entry1_under or 0
        entry2_under = entry2_under or 0
        if entry1_under > entry2_under then
          return false
        elseif entry1_under < entry2_under then
          return true
        end
      end,
      cmp.config.compare.kind,
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order,
    },
  },
  formatting = {
    fields = {
      cmp.ItemField.Kind,
      cmp.ItemField.Abbr,
      cmp.ItemField.Menu,
    },
    format = get_formatter(),
  },
  window = {
    completion = {
      border = 'rounded'
    },
    documentation = {
      border = 'rounded'
    },
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
        cmp.confirm({ select = true })
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
