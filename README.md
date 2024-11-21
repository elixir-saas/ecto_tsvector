# EctoTsvector

**TODO: Add description**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `ecto_tsvector` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ecto_tsvector, "~> 0.1.0"}
  ]
end
```

This library uses the `regconfig` type in Postgres.
Add support for this type by adding the following config for your repo:

```elixir
config :my_app, MyApp.Repo, types: EctoTsvector.PostgrexTypes
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/ecto_tsvector>.

