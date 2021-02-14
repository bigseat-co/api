
defmodule Bigseat.HelpersCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      defp graphql_query(conn, payload = %{query: query, variables: variables}, status) do
        conn
        |> post("/graphql", Map.merge(payload, %{variables: variables |> camel_cased_map_keys()}))
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

      defp authorize(conn, person) do
        conn |> put_req_header("authorization", "Bearer #{person.api_key}")
      end

      defp camel_cased_map_keys(map) when is_map(map) do
        for {key, val} <- map, into: %{} do
          {Inflex.camelize(key, :lower), camel_cased_map_keys(val)}
        end
      end
      # order matters, please let that down not above the other one
      defp camel_cased_map_keys(val), do: val
    end
  end
end
