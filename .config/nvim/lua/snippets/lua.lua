local split_by_dot = function(arg, position)
  local split = vim.split(arg, ".", { plain = true })

  if position == nil then
    return split
  end

  if position == 'first' then
    return split[1]
  end

  if position == 'last' then
    return split[#split]
  end
end

return {
  s(
    {
      trig = "ll",
      name = "Local var",
      desc = "Local var with assignment"
    },
    fmt(
      [[
        local {} = {}
        {}
      ]],
      {
        i(1, "var_name"),
        i(2, "value"),
        i(0)
      }
    )
  ),
  s(
    {
      trig = "lfun",
      name = "Local function",
      desc = "Require module safely and assign to local var"
    },
    fmt(
      [[
        local {} = function({})
          {}
        end
      ]],
      {
        i(1, "var_name"),
        i(2, "args"),
        i(0),
      }
    )
  ),
  s(
    {
      trig = "lpcall",
      name = "Local pcall",
      desc = "Require module safely and assign to local var"
    },
    fmt(
      [[
        local {}, {} = pcall(require, "{}")
        if not {} then
          vim.print("{} is absent")
          return
        end
        {}
      ]],
      {
        d(3, function(arg)
          return sn(nil, t(split_by_dot(arg[1][1], 'last') .. '_ok'))
        end, { 1 }),
        d(2, function(arg)
          return sn(nil, t(split_by_dot(arg[1][1], 'last')))
        end, { 1 }),
        i(1, "module"),
        rep(3),
        f(function(arg)
          return split_by_dot(arg[1][1], 'first')
        end, { 1 }),
        i(0)
      }
    )
  ),
  s(
    {
      trig = "lreq",
      name = "Local require",
      desc = "Require module and assign to local var"

    },
    fmt(
      [[
        local {} = require("{}")
        {}
      ]],
      {
        f(function(arg)
          return split_by_dot(arg[1][1], 'last')
        end, { 1 }),
        i(1, "module"),
        i(0)
      }
    )
  ),
  s(
    {
      trig = "vi",
      name = "Vim inspect",
      desc = "Vim inspect var"
    },
    fmt(
      [[
        vim.print(vim.inspect({}))
      ]],
      {
        i(1, "var"),
      }
    )
  ),
}
