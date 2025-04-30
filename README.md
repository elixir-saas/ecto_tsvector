# EctoTsvector

Add vector search to your application with Ecto, [tsvector](https://www.postgresql.org/docs/current/datatype-textsearch.html), and Postgres.

## Installation

Install by adding `ecto_tsvector` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ecto_tsvector, "~> 0.1.0"}
  ]
end
```

Full documentation at <https://hexdocs.pm/ecto_tsvector>.

This library uses the `regconfig` type in Postgres.
Add support for this type by adding the following config for your repo:

```elixir
config :my_app, MyApp.Repo, types: EctoTsvector.PostgrexTypes
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/ecto_tsvector>.

