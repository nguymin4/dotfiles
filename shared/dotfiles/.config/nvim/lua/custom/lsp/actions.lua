-- Remove default mapping which interfere with ReplaceWithRegister plugin
vim.keymap.del('n', 'gri')
vim.keymap.del('n', 'gra')
vim.keymap.del('x', 'gra')
vim.keymap.del('n', 'grn')

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

-- LSP workspace
vim.api.nvim_create_user_command('LspWorkspaceAdd', function()
  vim.lsp.buf.add_workspace_folder()
end, { desc = 'Add folder to workspace' })

vim.api.nvim_create_user_command('LspWorkspaceList', function()
  vim.notify(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end, { desc = 'List workspace folders' })

vim.api.nvim_create_user_command('LspWorkspaceRemove', function()
  vim.lsp.buf.remove_workspace_folder()
end, { desc = 'Remove folder from workspace' })

-- LSP handlers
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = 'rounded'
})

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = 'rounded', focusable = false,
})

-- LSP function signature
local lsp_signature_ok, lsp_signature = pcall(require, 'lsp_signature')
if lsp_signature_ok then
  lsp_signature.setup({
    bind = true,
    fix_pos = false,
    hint_enable = false,
    handler_opts = {
      border = 'rounded',
    },
  })
end
