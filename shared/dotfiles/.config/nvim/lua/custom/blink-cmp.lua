local blink_cmp_ok, blink_cmp = pcall(require, 'blink.cmp')
if blink_cmp_ok then
  vim.o.winborder = 'rounded'
  blink_cmp.setup({
    snippets = {
      preset = 'luasnip'
    },
    keymap = {
      preset = 'default',
      ['<C-space>'] = { 'select_and_accept' },
      ['<C-y>'] = { 'select_and_accept' },
      ['<C-e>'] = { 'hide' },
      ['<C-n>'] = { 'select_next', 'fallback_to_mappings' },
      ['<C-p>'] = { 'select_prev', 'fallback_to_mappings' },
      ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
      ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },
      ['<C-j>'] = { 'snippet_forward', 'fallback' },
      ['<C-k>'] = { 'snippet_backward', 'fallback' },
      ['<Tab>'] = { 'accept', 'fallback' },
      ['<Tab>'] = { 'accept', 'fallback' },
      ['<S-Tab>'] = { 'select_prev', 'fallback' },
    },
    signature = {
      enabled = false, -- To be configured in LSP
    }
  })
end

local luasnip_ok, _ = pcall(require, 'luasnip')
if luasnip_ok then
  require('luasnip.loaders.from_vscode').lazy_load()
end
