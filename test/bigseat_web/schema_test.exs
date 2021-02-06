defmodule BigseatWeb.SchemaTest do
  use BigseatWeb.ConnCase, async: true
  import Bigseat.Factory

  describe "spaces" do
    setup do
      [space: insert(:space)]
    end

    test "gets a space by id", %{conn: conn, space: %{id: id}} do
      query = """
      {
        space(id: "#{id}") {
          id
        }
      }
      """

      response = graphql_response(conn, query, :success)
      assert response == %{"data" => %{"space" => %{"id" => "#{id}"}}}
    end
  end


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
