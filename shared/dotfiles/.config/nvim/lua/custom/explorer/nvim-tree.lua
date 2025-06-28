local nvim_tree_ok, nvim_tree = pcall(require, 'nvim-tree')
if not nvim_tree_ok then
  return
end

local function on_attach(bufnr)
  local api = require('nvim-tree.api')
  local actions = require('nvim-tree.actions')

  -- marked files operation
  local bulk_cut = function()
    local marks = api.marks.list()
    if #marks == 0 then
      table.insert(marks, api.tree.get_node_under_cursor())
    end
    -- Do not use api.marks.bulk.move to avoid using prompt to input destination path
    for _, node in pairs(marks) do
      api.fs.cut(node)
    end
    api.marks.clear()
    api.tree.reload()
  end

  local bulk_copy = function()
    local marks = api.marks.list()
    if #marks == 0 then
      table.insert(marks, api.tree.get_node_under_cursor())
    end
    for _, node in pairs(marks) do
      api.fs.copy.node(node)
    end
    api.marks.clear()
    api.tree.reload()
  end

  local bulk_trash = function()
    local marks = api.marks.list()
    if #marks == 0 then
      table.insert(marks, api.tree.get_node_under_cursor())
    end
    api.marks.bulk.trash()
  end

  -- git
  local navigate_git = function(where)
    return actions.moves.item.fn({
      where = where,
      what = 'git',
      recurse = true,
      skip_gitignored = true
    })
  end

  local opts = function(desc)
    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  vim.keymap.set('n', 'a',  api.fs.create, opts('Create File Or Directory'))
  vim.keymap.set('n', 'r', api.fs.rename, opts('Rename'))
  vim.keymap.set('n', 'yn', api.fs.copy.filename, opts('Copy Name'))
  vim.keymap.set('n', 'yp', api.fs.copy.relative_path, opts('Copy Relative Path'))
  vim.keymap.set('n', 'yP', api.fs.copy.absolute_path, opts('Copy Absolute Path'))

  vim.keymap.set('n', 'm', api.marks.toggle, opts('Toggle Bookmark'))
  vim.keymap.set('n', 'p', api.fs.paste, opts('Paste'))
  vim.keymap.set('n', 'dd', bulk_cut, opts('Cut File(s)'))
  vim.keymap.set('n', 'yy', bulk_copy, opts('Copy File(s)'))
  vim.keymap.set('n', 'D', bulk_trash, opts('Trash File(s)'))
  vim.keymap.set('n', 'bD', api.marks.bulk.delete, opts('Remove File(s)'))

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
  vim.keymap.set('n', ']d', api.node.navigate.diagnostics.next_recursive, opts('Next Diagnostic'))
  vim.keymap.set('n', '[d', api.node.navigate.diagnostics.prev_recursive, opts('Prev Diagnostic'))
  vim.keymap.set('n', 'K', api.node.navigate.sibling.first, opts('First Sibling'))
  vim.keymap.set('n', 'J', api.node.navigate.sibling.last, opts('Last Sibling'))
  vim.keymap.set('n', 'P', api.node.navigate.parent, opts('Parent Directory'))
  vim.keymap.set('n', ']g', navigate_git('next'), opts('Next Git'))
  vim.keymap.set('n', '[g', navigate_git('prev'), opts('Prev Git'))
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
    show_on_dirs = true,
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
  ui = {
    confirm = {
      remove = true,
      trash = true,
      default_yes = false,
    },
  },
  on_attach = on_attach,
})

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
