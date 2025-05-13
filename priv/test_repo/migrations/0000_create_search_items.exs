defmodule EctoTsvector.TestRepo.Migrations.CreateSearchItems do
  use Ecto.Migration

  import EctoTsvector.Migration

  def change do
    create table(:search_items) do
      add :text, :text, null: true
    end

    add_tsvector_search(:search_items, :text, language_field: :lang)
  end
end
