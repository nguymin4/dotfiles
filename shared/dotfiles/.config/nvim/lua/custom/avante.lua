local avante_ok, avante = pcall(require, 'avante')
if not avante_ok then
  return
end

require('avante_lib').load()

avante.setup ({
  provider = "ollama",
  debug = false,
  behaviour = {
    auto_suggestions = false,
    auto_set_highlight_group = true,
    auto_set_keymaps = false,
    auto_apply_diff_after_generation = false,
    support_paste_from_clipboard = false,
  },
  vendors = {
    ollama = {
      ["local"] = true,
      endpoint = "http://localhost:11434/v1",
      model = "mistral",
      parse_curl_args = function(opts, code_opts)
        return {
          url = opts.endpoint .. "/chat/completions",
          body = {
            model = opts.model,
            messages = require("avante.providers").copilot.parse_message(code_opts),
            max_tokens = 1024,
            stream = true,
          },
        }
      end,
      parse_stream_data = function(data_stream, opts)
        if vim.startswith(data_stream, 'data: [DONE]') then
          opts.on_complete(nil)
          return
        end
        if vim.startswith(data_stream, 'data:') then
          local ok, data = pcall(vim.json.decode, string.sub(data_stream, 6))
          if not ok then
            return
          end
          if data.choices and data.choices[1] then
            local choice = data.choices[1]
            if choice.finish_reason == "stop" then
              opts.on_complete(nil)
            elseif choice.delta.content then
              if choice.delta.content ~= vim.NIL then opts.on_chunk(choice.delta.content) end
            end
          end
        end
      end,
    },
  },
})
