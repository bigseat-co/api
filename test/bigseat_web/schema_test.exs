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

      expected = %{"data" => %{"space" => %{"id" => "#{id}"}}}
      response = response(200, conn, query)
      assert response == expected
    end
  end

  defp response(status, conn, query) do
    conn
    |> post("/graphql", %{query: query})
    |> json_response(status)
  end
end
