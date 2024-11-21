defmodule EctoTsvector.Query do
  import Ecto.Query
  import EctoTsvector.Query.Fragment

  require Logger

  @doc """
  Applies a tsvector search to a query, using the primary schema of the query.

  ## Options

      * `:vector_field` - Set the field name to use for the search vector, defaults to `:search_vector`.
      * `:language_field` - Set the field name to use for the search language, defaults to `:search_language`.

  ## Examples

      def search_workspace_messages(workspace, search_term) do
        Message
        |> where([m], m.workspace_id == ^workspace.id)
        |> EctoTsvector.Query.tsvector_search_query(search_term)
        |> limit(10)
        |> Repo.all()
      end

  """
  @spec tsvector_search_query(Ecto.Query.t(), String.t()) :: Ecto.Query.t()
  @spec tsvector_search_query(Ecto.Query.t(), String.t(), Keyword.t()) :: Ecto.Query.t()
  def tsvector_search_query(query, search_term, opts \\ []) do
    from(s in query,
      where: query_fragment(s, search_term, opts),
      order_by: {:desc, ts_rank_cd_fragment(s, search_term, opts)}
    )
  end
end
