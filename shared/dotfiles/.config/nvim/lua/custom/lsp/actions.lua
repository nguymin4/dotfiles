-- LSP actions
vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    local opts = { buffer = event.buf }

    vim.keymap.set('n', '<C-Space>', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
    vim.keymap.set('n', 'gh', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
    vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
    vim.keymap.set('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
    vim.keymap.set('n', 'ge', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
    vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)

    vim.keymap.set('n', '<leader>2', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
    vim.keymap.set({ 'n', 'x' }, '<leader>f', '<cmd>lua vim.lsp.buf.format({ async = true })<cr>', opts)
    vim.keymap.set('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)

    vim.keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>', opts)
    vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>', opts)
    vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>', opts)
  end
})

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = 'rounded'
})

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = 'rounded', focusable = false,
})

vim.api.nvim_create_user_command('LspWorkspaceAdd', function()
  vim.lsp.buf.add_workspace_folder()
end, { desc = 'Add folder to workspace' })

vim.api.nvim_create_user_command('LspWorkspaceList', function()
  vim.notify(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end, { desc = 'List workspace folders' })

vim.api.nvim_create_user_command('LspWorkspaceRemove', function()
  vim.lsp.buf.remove_workspace_folder()
end, { desc = 'Remove folder from workspace' })

-- aerial.nvim
local aerial_ok, aerial = pcall(require, 'aerial')
if aerial_ok then
  aerial.setup({
    autojump = true,
    show_guides = true,
    layout = {
      default_direction = 'prefer_right',
      min_width = 25,
    },
    keymaps = {
      ['?'] = 'actions.show_help',
      ['g?'] = 'actions.show_help',
      ['<CR>'] = 'actions.jump',
      ['<2-LeftMouse>'] = 'actions.jump',
      ['<C-v>'] = 'actions.jump_vsplit',
      ['<C-s>'] = 'actions.jump_split',
      ['p'] = 'actions.scroll',
      ['<C-j>'] = false,
      ['<C-k>'] = false,
      ['{'] = 'actions.prev',
      ['}'] = 'actions.next',
      ['[['] = 'actions.prev_up',
      [']]'] = 'actions.next_up',
      ['q'] = 'actions.close',
      ['o'] = 'actions.tree_toggle',
      ['za'] = 'actions.tree_toggle',
      ['O'] = 'actions.tree_toggle_recursive',
      ['zA'] = 'actions.tree_toggle_recursive',
      ['l'] = 'actions.tree_open',
      ['zo'] = 'actions.tree_open',
      ['L'] = 'actions.tree_open_recursive',
      ['zO'] = 'actions.tree_open_recursive',
      ['h'] = 'actions.tree_close',
      ['zc'] = 'actions.tree_close',
      ['H'] = 'actions.tree_close_recursive',
      ['zC'] = 'actions.tree_close_recursive',
      ['zr'] = 'actions.tree_increase_fold_level',
      ['zR'] = 'actions.tree_open_all',
      ['zm'] = 'actions.tree_decrease_fold_level',
      ['zM'] = 'actions.tree_close_all',
      ['zx'] = 'actions.tree_sync_folds',
      ['zX'] = 'actions.tree_sync_folds',
    },
  })
  vim.keymap.set('n', '<leader>v', '<cmd>AerialToggle!<CR>')
end
