defmodule EctoTsvector.Migration do
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
