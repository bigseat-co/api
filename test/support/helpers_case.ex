
defmodule Bigseat.HelpersCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      defp graphql_response(conn, query, status) do
        conn
        |> post("/graphql", %{query: query})
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
