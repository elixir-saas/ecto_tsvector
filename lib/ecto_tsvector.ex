# Define Postgrex types for `"regconfig"`.
Application.put_env(:postgrex_text_ext, :type_names, ["regconfig"])
Postgrex.Types.define(EctoTsvector.PostgrexTypes, [PostgrexTextExt])

defmodule EctoTsvector do
  @moduledoc """
  Add vector search with Ecto to your existing Postgres database.
  """
end
