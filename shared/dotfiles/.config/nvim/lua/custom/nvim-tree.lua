local nvim_tree_ok, nvim_tree = pcall(require, 'nvim-tree')
if not nvim_tree_ok then
  return
end

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local api = require('nvim-tree.api')

local function on_attach(bufnr)
  local function opts(desc)
    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  vim.keymap.set('n', 'a',  api.fs.create, opts('Create File Or Directory'))
  vim.keymap.set('n', 'dd', api.fs.cut, opts('Cut'))
  vim.keymap.set('n', 'yy', api.fs.copy.node, opts('Copy'))
  vim.keymap.set('n', 'yn', api.fs.copy.filename, opts('Copy Name'))
  vim.keymap.set('n', 'yp', api.fs.copy.relative_path, opts('Copy Relative Path'))
  vim.keymap.set('n', 'yP', api.fs.copy.absolute_path, opts('Copy Absolute Path'))
  vim.keymap.set('n', 'D', api.fs.trash, opts('Trash'))
  vim.keymap.set('n', 'p', api.fs.paste, opts('Paste'))
  vim.keymap.set('n', 'r', api.fs.rename, opts('Rename'))

  vim.keymap.set('n', 'bd', api.marks.bulk.delete, opts('Delete Bookmarked'))
  vim.keymap.set('n', 'bD', api.marks.bulk.trash, opts('Trash Bookmarked'))
  vim.keymap.set('n', 'bmv', api.marks.bulk.move, opts('Move Bookmarked'))
  vim.keymap.set('n', 'm', api.marks.toggle, opts('Toggle Bookmark'))

  vim.keymap.set('n', 'u', api.tree.change_root_to_parent, opts('Up'))
  vim.keymap.set('n', 'cd', api.tree.change_root_to_node, opts('CD'))
  vim.keymap.set('n', 'E', api.tree.expand_all, opts('Expand All'))
  vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
  vim.keymap.set('n', 'H', api.tree.toggle_hidden_filter, opts('Toggle Filter: Hidden'))
  vim.keymap.set('n', 'q', api.tree.close, opts('Close'))
  vim.keymap.set('n', 'R', api.tree.reload, opts('Refresh'))

  vim.keymap.set('n', '<CR>', api.node.open.edit, opts('Open'))
  vim.keymap.set('n', 'i', api.node.open.horizontal, opts('Open: Horizontal Split'))
  vim.keymap.set('n', 's', api.node.open.vertical, opts('Open: Vertical Split'))
  vim.keymap.set('n', ']e', api.node.navigate.diagnostics.next, opts('Next Diagnostic'))
  vim.keymap.set('n', '[e', api.node.navigate.diagnostics.prev, opts('Prev Diagnostic'))
  vim.keymap.set('n', 'K', api.node.navigate.sibling.first, opts('First Sibling'))
  vim.keymap.set('n', 'J', api.node.navigate.sibling.last, opts('Last Sibling'))
  vim.keymap.set('n', 'P', api.node.navigate.parent, opts('Parent Directory'))
  vim.keymap.set('n', '[c', api.node.navigate.git.prev, opts('Prev Git'))
  vim.keymap.set('n', ']c', api.node.navigate.git.next, opts('Next Git'))
end

nvim_tree.setup({
  -- Avoid gf change root due to netrw
  hijack_netrw = false,
  -- Update root when running :cd path
  sync_root_with_cwd = true,
  actions = {
    change_dir = {
      enable = true,
      global = true,
      -- Need to disable so change_root_to_parent works
      restrict_above_cwd = false,
    },
    expand_all = {
      max_folder_discovery = 1,
    },
    open_file = {
      window_picker = {
        enable = false
      },
    },
  },
  diagnostics = {
    enable = true,
    severity = {
      min = vim.diagnostic.severity.WARN,
      max = vim.diagnostic.severity.ERROR,
    },
  },
  filters = {
    dotfiles = false,
  },
  git = {
    ignore = false,
  },
  notify = {
    threshold = vim.log.levels.ERROR,
  },
  on_attach = on_attach,
})

function nvim_tree_find_file(filepath)
  local cwd = vim.fn.getcwd()
  local is_in_scope = filepath:sub(1, #cwd) == cwd
  if is_in_scope then
    api.tree.find_file({
      buf = filepath,
      open = true,
      focus = true,
    })
    api.tree.expand_all()
  else
    require('telescope.builtin').find_files({
      cwd = filepath,
      hidden = true,
      prompt_title = 'List files in ' .. filepath:gsub(vim.env.HOME, "~")
    })
  end
end

-- Setup file icons for nvim tree
local nvim_web_devicons_ok, nvim_web_devicons = pcall(require, 'nvim-web-devicons')
if nvim_web_devicons_ok then
  nvim_web_devicons.set_icon({
    tf = {
      icon = '',
      color = '#e79aff',
      cterm_color = '98',
      name = 'Terraform'
    }
  })
end
