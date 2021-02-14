defmodule BigseatWeb.Schema.ListSpacesTest do
  use BigseatWeb.ConnCase, async: true
  import Bigseat.Factory
  use Bigseat.HelpersCase

  describe "get_space" do
    setup do
      [
        space: insert(:space),
        # person: insert(:person)
      ]
    end

    # test "get list of spaces without authentication", %{conn: conn} do
    #   response = graphql_query(conn, %{query: query()}, :success)
    #   assert Map.has_key?(response, "errors")
    # end

    test "gets a space by id", %{conn: conn, space: space} do
      # auth_conn = conn |> authorize(person)

      response = graphql_query(conn, %{query: query()}, :success)
      assert response == %{"data" => %{"listSpaces" => [%{"id" => "#{space.id}"}]}}
    end


    defp query do
      """
      query {
        listSpaces {
          id
        }
      }
      """
    end
  end
end
