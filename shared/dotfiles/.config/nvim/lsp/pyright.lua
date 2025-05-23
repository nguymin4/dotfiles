return {
  settings = {
    python = {
      analysis = {
        autoImportCompletions = true,
        autoSearchPaths = true,
        diagnosticMode = 'openFilesOnly',
        typeCheckingMode = 'basic',
        useLibraryCodeForTypes = true,
        -- Ignore all files for analysis to exclusively use Ruff for linting
        ignore = {'*'},
      },
    },
  },
}
