import Config

config :ecto_tsvector, EctoTsvector.TestRepo, types: EctoTsvector.PostgrexTypes

config :ecto_tsvector,
  ecto_repos: [EctoTsvector.TestRepo]

config :ecto_tsvector, EctoTsvector.TestRepo,
  username: "postgres",
  password: "postgres",
  database: "ecto_tsvector_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

config :logger, level: :warning
