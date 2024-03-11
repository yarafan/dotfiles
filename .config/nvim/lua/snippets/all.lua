local get_date = function(_, _, user_arg)
  local file = io.popen("date" .. " " .. user_arg)
  if file == nil then
    return ""
  end

  local date = file:read("l")
  file:close()

  return date
end

return {
  s(
    {
      trig = "date",
      name = "Current date",
      desc = { "Choices:", "1. ISO 8601", "2. YYYY-MM-DD", "3. DD-MM-YYYY" },
    },
    fmt(
      [[
        "{}"
      ]],
      {
        c(1, {
          f(
            get_date,
            {},
            {
              user_args = { "-Iseconds" }
            }
          ),
          f(
            get_date,
            {},
            {
              user_args = { "+%d-%m-%Y" }
            }
          ),
          f(
            get_date,
            {},
            {
              user_args = { "+%Y-%m-%d" }
            }
          ),
        })
      }
    )
  ),
  s(
    {
      trig = "uuid",
      name = "UUID v4",
      desc = "Generate UUID v4",
    },
    fmt(
      [[
        "{}"
      ]],
      {
        f(function()
          local file = io.popen("uuidgen")
          if file == nil then
            return ""
          end

          local uuid = file:read("l"):lower()
          file:close()
          return uuid
        end, {}),
      }
    )
  )
}
