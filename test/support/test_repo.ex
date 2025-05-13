defmodule EctoTsvector.TestRepo do
  use Ecto.Repo,
    otp_app: :ecto_tsvector,
    adapter: Ecto.Adapters.Postgres
end
