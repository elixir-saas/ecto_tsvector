defmodule EctoTsvector.MixProject do
  use Mix.Project

  def project do
    [
      app: :ecto_tsvector,
      version: "0.1.0",
      elixir: "~> 1.17",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:ecto, "~> 3.12"},
      {:postgrex_text_ext, "~> 0.1.0"}
    ]
  end
end
