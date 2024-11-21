defmodule EctoTsvector.Query.Fragment do
  defmacro query_fragment(schema, search_term, opts) do
    quote do
      fragment(
        "? @@ websearch_to_tsquery(?, ?)",
        field(unquote(schema), ^(unquote(opts)[:vector_field] || :search_vector)),
        field(unquote(schema), ^(unquote(opts)[:language_field] || :search_language)),
        ^unquote(search_term)
      )
    end
  end

  defmacro ts_rank_cd_fragment(schema, search_term, opts) do
    quote do
      fragment(
        "ts_rank_cd(?, websearch_to_tsquery(?, ?), 4)",
        field(unquote(schema), ^(unquote(opts)[:vector_field] || :search_vector)),
        field(unquote(schema), ^(unquote(opts)[:language_field] || :search_language)),
        ^unquote(search_term)
      )
    end
  end
end
