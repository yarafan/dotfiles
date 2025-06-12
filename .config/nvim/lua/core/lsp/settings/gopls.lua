return {
  settings = {
    gopls = {
      ["local"] = "gitlab.wildberries.ru",
      buildFlags = { "-tags=build tools integrational" },
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
    }
  },
}
