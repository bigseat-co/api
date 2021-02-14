
defmodule Bigseat.HelpersCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      defp graphql_query(conn, payload = %{query: query, variables: variables}, status) do
        conn
        |> post("/graphql", payload)
        |> assert_response(status)
      end

      defp graphql_query(conn, payload = %{query: query}, status) do
        conn
        |> post("/graphql", payload)
        |> assert_response(status)
      end

      defp assert_response(conn, status) do
        case status do
          :success -> json_response(conn, 200)
        end
      end
    end
  end
end
