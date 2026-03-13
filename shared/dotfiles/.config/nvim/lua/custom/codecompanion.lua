local codecompanion_ok, codecompanion = pcall(require, 'codecompanion')
if not codecompanion_ok then
  return
end

codecompanion.setup({
  -- gemini_cli is very slow at startup thus it's not great UX for chat and inline interactions
  interactions = {
    chat = {
      adapter = 'ollama'
    },
    inline = {
      adapter = 'ollama',
    },
    agent = {
      adapter = 'opencode',
    },
  },
  adapters = {
    acp = {
      gemini_cli = function()
        return require('codecompanion.adapters').extend('gemini_cli', {
          commands = {
            default = { 'gemini', '--acp' },
            yolo = { 'gemini', '--yolo', '--acp' },
          },
          defaults = {
            auth_method = 'oauth-personal',
          },
        })
      end,
      opencode = "opencode",
      opts = {
        show_presets = false
      },
    },
    http = {
      ollama = function()
        return require('codecompanion.adapters').extend('ollama', {
          parameters = {
            sync = true,
          },
        })
      end,
      opts = {
        show_presets = false
      },
    },
  },
  display = {
    chat = {
      show_settings = false, -- Settings to true prevent changing adapter and model
      start_in_insert_mode = false,
      window = {
        layout = 'vertical',
        position = 'right',
      },
    },
  },
})

vim.keymap.set({ 'n', 'v' }, '<C-a>', '<cmd>CodeCompanionActions<cr>', { noremap = true, silent = true })
vim.keymap.set({ 'n', 'v' }, '<leader>c', '<cmd>CodeCompanionChat Toggle<cr>', { noremap = true, silent = true })
vim.keymap.set('v', 'gA', '<cmd>CodeCompanionChat Add<cr>', { noremap = true, silent = true })

-- Expand 'cc' into 'CodeCompanion' in the command line
vim.cmd([[cab cc CodeCompanion]])


-- Setup status spinner
local spinner_ok, spinner = pcall(require, 'codecompanion._extensions.spinner')
if spinner_ok then
  spinner.setup({
    style = 'native',
    native = {
      done_timer = 1000,
      win_options = {
        winblend = 20,
      },
    },
  })
end
