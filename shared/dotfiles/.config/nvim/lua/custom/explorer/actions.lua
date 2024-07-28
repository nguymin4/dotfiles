local gdgf_filetypes = {
  'javascript',
  'javascriptreact',
  'typescript',
  'typescriptreact',
  'terraform'
}

local function find_folder(folder_path)
  local cwd = vim.fn.getcwd()
  local is_in_scope = folder_path:sub(1, #cwd) == cwd
  if is_in_scope then
    local api = require('nvim-tree.api')
    api.tree.find_file({
      buf = folder_path,
      open = true,
      focus = true,
    })
    api.tree.expand_all()
  else
    require('telescope.builtin').find_files({
      cwd = folder_path,
      hidden = true,
      prompt_title = 'List files in ' .. folder_path:gsub(vim.env.HOME, "~")
    })
  end
end

local function go_to_definition_or_file()
  -- Get the filename under the cursor and expand the tilde
  local expanded_filename = vim.fn.expand(vim.fn.expand('<cfile>'))

  -- If the file path is relative, resolve to get abs path
  if string.find(expanded_filename, '^%.%.?/') ~= nil then
    expanded_filename = vim.fs.joinpath(vim.fn.expand('%:p:h'), expanded_filename)
    expanded_filename = vim.fs.normalize(expanded_filename)
  end

  local is_dir = vim.fn.isdirectory(expanded_filename) == 1
  if vim.tbl_contains(gdgf_filetypes, vim.bo.filetype) then
    if  vim.fn.empty(vim.fn.glob(expanded_filename)) == 1 then
      -- If file not found, attempt to use LSP and quit
      vim.lsp.buf.definition()
      return
    elseif is_dir then
      -- In case of a folder, use LSP then reveal it in nvim-tree
      vim.lsp.buf.definition()
    end
  end

  if is_dir then
    find_folder(expanded_filename)
  else
    vim.cmd([[silent normal! gf]])
  end
end

vim.keymap.set('n', 'gf', go_to_definition_or_file, { noremap = true, silent = true, nowait = true })
