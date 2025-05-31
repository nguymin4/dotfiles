return {
  on_attach = function(client, bufnr)
    if client.name == 'ruff' then
      -- Disable hover in favor of Pyright
      client.server_capabilities.hoverProvider = false
    end
  end,
  capabilities = {
    general = {
      -- To be compatible with Pyright which uses utf-16 by default
      positionEncodings = { "utf-16" }
    }
  }
}
