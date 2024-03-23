# envious nimbleparsec

```elixir
Mix.install([
  {:nimble_parsec, "~> 1.4"}
])
```

## example1

```elixir
defmodule MyParser do
  import NimbleParsec

  date =
    integer(4)
    |> ignore(string("-"))
    |> integer(2)
    |> ignore(string("-"))
    |> integer(2)

  time =
    integer(2)
    |> ignore(string(":"))
    |> integer(2)
    |> ignore(string(":"))
    |> integer(2)
    |> optional(string("Z"))

  defparsec(:datetime, date |> ignore(string("T")) |> concat(time), debug: false)
end

MyParser.datetime("2010-04-17T14:12:34Z")
```

```elixir
defmodule Envious do
  import NimbleParsec

  key =
    utf8_string([], 1)
    |> repeat()
    |> ignore(string("="))

  value =
    repeat(ascii_char([?a..?z]))

  defparsec(:parse, key |> concat(value), debug: false)
end

envs = string("FOO=bar")

Envious.parse(env)
```
