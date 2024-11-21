defmodule EctoTsvector.Dictionary do
  @moduledoc """
  Helper module for Postgres supported language dictionaries.
  """

  @postgres_language_mapping %{
    "en" => "english",
    "ar" => "arabic",
    "hy" => "armenian",
    "ca" => "catalan",
    "da" => "danish",
    "nl" => "dutch",
    "fi" => "finnish",
    "fr" => "french",
    "de" => "german",
    "el" => "greek",
    "hi" => "hindi",
    "hu" => "hungarian",
    "id" => "indonesian",
    "it" => "italian",
    "lt" => "lithuanian",
    "ne" => "nepali",
    "no" => "norwegian",
    "pt" => "portuguese",
    "ro" => "romanian",
    "ru" => "russian",
    "sr" => "serbian",
    "es" => "spanish",
    "sv" => "swedish",
    "ta" => "tamil",
    "tr" => "turkish"
  }

  @doc """
  Returns the generic language dictionary for Postgres: `"simple"`.
  """
  @spec generic() :: String.t()
  def generic(), do: "simple"

  @doc """
  Maps a two character language code to the corresponding language dictionary in Postgres,
  raises if the language code is not recognized.

  Omits language localizations, i.e. `"en-US"` is treated identically to `"en"`.
  """
  @spec language_code_to_postgres(String.t()) :: String.t()
  def language_code_to_postgres!(language_code) do
    @postgres_language_mapping[String.slice(language_code, 0..1)] ||
      raise "Language code '#{language_code}' does not resolve to a supported dictionary in Postgres"
  end

  @doc """
  Maps a two character language code to the corresponding language dictionary in Postgres,
  returns the generic dictionary if the language code is not recognized.

  Omits language localizations, i.e. `"en-US"` is treated identically to `"en"`.
  """
  @spec language_code_to_postgres(String.t()) :: String.t()
  def language_code_to_postgres(language_code) when is_binary(language_code) do
    @postgres_language_mapping[String.slice(language_code, 0..1)] || generic()
  end
end
