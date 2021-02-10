defmodule BigseatWeb.Schema.SpaceTest do
  use BigseatWeb.ConnCase, async: true
  import Bigseat.Factory
  use Bigseat.HelpersCase

  describe "spaces" do
    setup do
      [space: insert(:space)]
    end

    test "gets a space by id", %{conn: conn, space: %{id: id}} do
      query = """
      query {
        space(id: "#{id}") {
          id
        }
      }
      """

      response = graphql_query(conn, query, :success)
      assert response == %{"data" => %{"space" => %{"id" => "#{id}"}}}
    end
  end
end
