local gitsigns_ok, gitsigns = pcall(require, 'gitsigns')
if not gitsigns_ok then
  return
end

gitsigns.setup({
  signcolumn = true,
  numhl = true,
  linehl = false,
  word_diff = false, -- Disable due to a bug with bg color and indentation
  current_line_blame = false,
  current_line_blame_opts = {
    delay = 250,
  },
  preview_config = {
    border = 'rounded',
  },
  on_attach = function(bufnr)
    local function map(mode, l, r, desc)
      opts = { desc = 'gitsigns: ' .. desc, buffer = bufnr }
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']g', function()
      if vim.wo.diff then
        vim.cmd.normal({ ']g', bang = true })
      else
        gitsigns.nav_hunk('next')
      end
    end, 'Go to next hunk')

    map('n', '[g', function()
      if vim.wo.diff then
        vim.cmd.normal({ '[g', bang = true })
      else
        gitsigns.nav_hunk('prev')
      end
    end, 'Go to prev hunk')

    -- Actions
    map('n', '<leader>hs', gitsigns.stage_hunk, 'Stage hunk')
    map('n', '<leader>hr', gitsigns.reset_hunk, 'Reset hunk')
    map('v', '<leader>hs', function() gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end, 'Stage hunk')
    map('v', '<leader>hr', function() gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end, 'Reset hunk')
    map('n', '<leader>hu', gitsigns.undo_stage_hunk, 'Undo stage hunk')
    map('n', '<leader>hv', gitsigns.preview_hunk, 'Preview hunk')
    map('n', '<leader>hb', function() gitsigns.blame_line({ full=true }) end, 'Git blame line')
    map('n', '<leader>htb', gitsigns.toggle_current_line_blame, 'Toggle git blame for current line')
    map('n', '<leader>hd', gitsigns.diffthis, 'Git diff')
    map('n', '<leader>hD', function() gitsigns.diffthis('~') end, 'Git diff last commit')
    map('n', '<leader>4', function()
      gitsigns.toggle_linehl()
      gitsigns.toggle_deleted()
    end, 'Toggle line highlighting and deleted lines')

    -- Text object
    map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>', 'Select textobject @hunk')
  end
})
