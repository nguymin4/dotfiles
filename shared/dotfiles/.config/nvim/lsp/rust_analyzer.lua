return {
  settings = {
    ["rust-analyzer"] = {
      checkOnSave = true,
      check = {
        command = "clippy",
      },
      procMacro = {
        enable = true,
      },
    },
  },
}
