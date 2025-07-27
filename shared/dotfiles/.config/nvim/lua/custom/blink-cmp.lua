local blink_cmp_ok, blink_cmp = pcall(require, 'blink.cmp')
if not blink_cmp_ok then
  return
end

blink_cmp.setup({
  completion = {
    menu = {
      border = 'rounded',
      max_height = 18,
    },
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 50,
      treesitter_highlighting = true,
      window = {
        border = 'rounded'
      }
    },
  },
  signature = {
    enabled = true,
    window = {
      border = 'rounded'
    }
  },
  snippets = {
    preset = 'luasnip'
  },
  sources = {
    default = { 'lsp', 'buffer', 'snippets', 'path' },
    providers = {
      lsp = {
        fallbacks = {} -- Always show buffer source
      },
      buffer = {
        opts = {
          get_bufnrs = function()
            return vim.api.nvim_list_bufs()
          end,
        },
      },
    },
  },
  fuzzy = {
    implementation = 'prefer_rust',
    max_typos = 0,
    sorts = {
      'exact',
      'score',
      'kind',
      'sort_text',
    },
  },
  keymap = {
    preset = 'none',
    ['<C-space>'] = { 'select_and_accept' },
    ['<C-y>'] = { 'select_and_accept' },
    ['<C-e>'] = { 'hide', 'fallback' },
    ['<C-n>'] = { 'select_next', 'fallback_to_mappings' },
    ['<C-p>'] = { 'select_prev', 'fallback_to_mappings' },
    ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
    ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },
    ['<C-j>'] = { 'snippet_forward', 'fallback' },
    ['<C-k>'] = { 'snippet_backward', 'fallback' },
    ['<Tab>'] = { 'select_and_accept', 'fallback' },
    ['<S-Tab>'] = { 'select_prev', 'fallback' },
  },
})

local luasnip_ok, _ = pcall(require, 'luasnip')
if luasnip_ok then
  require('luasnip.loaders.from_vscode').lazy_load()
end
