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
      adapter = 'gemini_cli',
    },
  },
  adapters = {
    acp = {
      gemini_cli = function()
        return require('codecompanion.adapters').extend('gemini_cli', {
          commands = {
            default = {
              'gemini',
              '--acp',
            },
            yolo = {
              'gemini',
              '--yolo',
              '--acp',
            },
          },
          defaults = {
            auth_method = 'oauth-personal',
          },
        })
      end,
    },
    http = {
      ollama = function()
        return require('codecompanion.adapters').extend('ollama', {
          parameters = {
            sync = true,
          },
        })
      end,
    },
  },
  display = {
    chat = {
      show_settings = false, -- Settings to true prevent changing adapter and model
      start_in_insert_mode = true,
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
