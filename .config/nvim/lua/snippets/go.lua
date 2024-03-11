return {
  s(
    {
      trig = "im",
      name = "Import declaration",
      desc = "Import declaration",
    },
    fmt(
      [[
        import (
          "{}"
        )
        {}
      ]],
      {
        i(1, "package"),
        i(0)
      }
    )
  ), s(
  {
    trig = "co",
    name = "Constant declaration",
    desc = "Constant declaration",
  },
  fmt(
    [[
        const (
          {} = {}
        )
      ]],
    {
      i(1, "name"),
      i(2, "value")
    }
  )
),
  s(
    {
      trig = "tyd",
      name = "Type declaration",
      desc = { "Choices:", "- Struct", "- Interface", "- Function" },
    },
    fmt(
      [[
        {}
      ]],
      {
        c(1, {
          sn(nil, fmta(
            [[
              type <> struct {
                <>
              }
            ]],
            {
              i(1),
              i(2)
            }
          )),
          sn(nil, fmta(
            [[
              type <> interface {
                <>
              }
            ]],
            {
              i(1),
              i(2)
            }
          )),
          sn(nil, fmta(
            [[
              type <> func(<>) <>
              <>
            ]],
            {
              i(1),
              i(2),
              i(3),
              i(4)
            }
          ))
        })
      }
    )
  ),
  s(
    {
      trig = "var",
      name = "Variable declaration",
      desc = "Variable declaration"
    },
    fmt(
      [[
        var (
          {}
        )
        {}
      ]],
      {
        c(1, {
          sn(nil, fmt(
            [[
                {} {}
            ]],
            {
              i(1),
              i(2, "type"),
            }
          )),
          sn(nil, fmt(
            [[
                {} {} = {}
            ]],
            {
              i(1),
              i(2, "type"),
              i(3, "value"),
            }
          )),
          sn(nil, fmt(
            [[
                {} = {}
            ]],
            {
              i(1),
              i(2, "value"),
            }
          )),
        }),
        i(0)
      }
    )
  ),
  s(
    {
      trig = "fun",
      name = "Function declaration",
      desc = "Function declaration"
    },
    fmt(
      [[
        {}
        {}
      ]],
      {
        c(1, {
          sn(nil, fmta(
            [[
              func <>(<>) <> {
                <>
              }
            ]],
            {
              i(1),
              i(2, "args"),
              i(3, "retval"),
              i(4, "body"),
            }
          )),
          sn(nil, fmta(
            [[
              func (<> <>) <>(<>) <> {
                <>
              }
            ]],
            {
              i(1),
              i(2, "reciever"),
              i(3, "name"),
              i(4, "args"),
              i(5, "retval"),
              i(6),
            }
          )),
        }),
        i(0)
      }
    )
  ),
  s(
    {
      trig = "map([^[].+),([^[].+)",
      trigEngine = "ecma",
      name = "Map declaration",
      desc = "Map declaration"
    },
    fmt(
      [[
        map[{}]{}
      ]],
      {
        f(function(_, snip)
          return snip.captures[1]
        end, {}),
        f(function(_, snip)
          return snip.captures[2]
        end, {}),
      }
    )
  ),
  s(
    {
      trig = "make",
      name = "Make declaration",
      desc = "Make declaration"
    },
    fmt(
      [[
        make({}, {})
      ]],
      {
        i(1, "elem"),
        d(2, function(arg)
          local input = arg[1][1]
          vim.print(input)
          if input:find("map") then
            return sn(nil, i(1, "0"))
          end
          vim.print("---")

          return sn(nil, fmt(
            [[
              {}, {}
            ]],
            {

              i(1, "0"),
              i(2, "0")
            }
          ))
        end, { 1 }),
      }
    )
  ),
  s(
    {
      trig = "switch",
      name = "Switch declaration",
      desc = "Switch declaration"
    },
    fmta(
      [[
        switch <> {
        case <>:
          <>
        }
      ]],
      {
        i(1, "var"),
        i(2, "value"),
        i(3),
      }
    )
  ),
  s(
    {
      trig = "forr",
      name = "For range loop",
      desc = "For range loop"
    },
    fmta(
      [[
        for <>, <> := range <> {
          <>
        }
      ]],
      {
        i(1, "_"),
        i(2, "var"),
        i(3, "collection"),
        i(0)
      }
    )
  ),
  s(
    {
      trig = "pf",
      name = "Print formatted",
      desc = "Print formatted"
    },
    fmt(
      [[
        fmt.Printf("{}", {})
      ]],
      {
        i(1, "string"),
        i(2, "values"),
      }
    )
  ),
  s(
    {
      trig = "om",
      name = "Object in map",
      desc = "Object in map"
    },
    fmta(
      [[
        if <>, ok := <>; <> {
          <>
        }
      ]],
      {
        i(1, "_"),
        i(2, "map[key]"),
        c(3, {
          t("ok"),
          t("!ok")
        }),
        i(0)
      }
    )
  ),
  s(
    {
      trig = "errn",
      name = "Error nil",
      desc = "Error nil"
    },
    fmt(
      [[
        {}
        {}
      ]],
      {
        d(1, function(_, snip)
          local input = snip.env.TM_SELECTED_TEXT[1]
          if input == nil then
            return sn(nil,
              fmta(
                [[
                if err <> nil {
                  <>
                }
              ]],
                {
                  c(1, {
                    t("!="),
                    t("==")
                  }),
                  i(2)
                }
              )
            )
          end

          local parts = vim.split(input, "=", { plain = true })
          if input ~= nil and not parts[1]:find(",") then
            return sn(nil,
              fmta(
                [[
                  if <>; err <> nil {
                    <>
                  }
                ]],
                {
                  t(input),
                  c(1, {
                    t("!="),
                    t("==")
                  }),
                  i(2)
                }
              )
            )
          end

          if input ~= nil and parts[1]:find(",") then
            return sn(nil,
              fmta(
                [[
                  <>
                  if err <> nil {
                    <>
                  }
                ]],
                {
                  t(input),
                  c(1, {
                    t("!="),
                    t("==")
                  }),
                  i(2)
                }
              )
            )
          end
        end, {}),
        i(0)
      }
    )
  ),
}
