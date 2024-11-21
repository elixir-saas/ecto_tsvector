defmodule EctoTsvector.Migration do
  @moduledoc """
  Add tsvector fields in Ecto migrations.
  """

  @doc """
  Adds a column of type `:regconfig` to a table containing the search language for a
  particular record, along with a tsvector column that targets a pre-existing field that is
  compatible with tsvector (the `field` argument). Creates a `gin` index on the vector and
  language fields for efficient search.

  ## Options

      * `:vector_field` - Name of the tsvector column, defaults to `:search_vector`.
      * `:language_field` - Name of the regconfig language column, defaults to `:search_language`.
      * `:default_language` - The default dictionary to replace null values, defaults to `"simple"`.

  ## Examples

      defmodule MyApp.Repo.Migrations.AlterMessagesAddTsvectorSearch do
        use Ecto.Migration

        import EctoTsvector.Migration

        def change do
          add_tsvector_search(:messages, :text, default_language: "english")
        end
      end

  """
  defmacro add_tsvector_search(table, field, opts \\ []) do
    vector_field = opts[:vector_field] || :search_vector
    language_field = opts[:language_field] || :search_language
    default_language = opts[:default_language] || "simple"

    quote do
      alter table(unquote(table)) do
        add(unquote(language_field), :regconfig,
          null: false,
          default: unquote(default_language)
        )
      end

      execute(
        """
        ALTER TABLE #{unquote(table)}
          ADD COLUMN #{unquote(vector_field)} tsvector
          GENERATED ALWAYS AS ( to_tsvector(#{unquote(language_field)}, #{unquote(field)}) ) STORED
        ;
        """,
        """
        ALTER TABLE #{unquote(table)} DROP COLUMN #{unquote(vector_field)} ;
        """
      )

      execute(
        """
        CREATE INDEX #{"#{unquote(table)}_#{unquote(vector_field)}_index"}
          ON #{unquote(table)}
          USING gin(#{unquote(vector_field)})
        ;
        """,
        """
        DROP INDEX #{"#{unquote(table)}_#{unquote(vector_field)}_index"} ;
        """
      )
    end
  end
end
