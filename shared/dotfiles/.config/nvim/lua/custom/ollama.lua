local gen_ok, gen = pcall(require, 'gen')
if not gen_ok then
  return
end

gen.setup({
  model = 'mistral',
  quit_map = 'q',
  retry_map = '<c-r>',
  accept_map = '<c-cr>',
  host = 'localhost',
  port = '11434',
  display_mode = 'split',
  show_prompt = false,
  show_model = true,
  no_auto_close = false,
  hidden = false,
  init = function(options)
    -- Noop
    return
  end,
  command = function(options)
    return 'curl --silent --no-buffer -X POST http://' .. options.host .. ':' .. options.port .. '/api/chat -d $body'
  end,
  debug = false
})

vim.api.nvim_create_user_command('GenSelectModel', function(args)
  gen.select_model()
end, {})
