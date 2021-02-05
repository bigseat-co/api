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

      res =
        conn
        |> post("/graphql", %{query: query})
        |> json_response(200)

      assert res == %{"data" => %{"space" => %{"id" => "#{id}"}}}
    end
  end
end
