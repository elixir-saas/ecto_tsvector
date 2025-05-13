defmodule SearchItem do
  use Ecto.Schema

  schema "search_items" do
    field(:text, :string)
    field(:lang, :string)
  end
end
