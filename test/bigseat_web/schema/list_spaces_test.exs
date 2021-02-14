defmodule BigseatWeb.Schema.ListSpacesTest do
  use BigseatWeb.ConnCase, async: true
  import Bigseat.Factory
  use Bigseat.HelpersCase

  describe "get_space" do
    setup do
      [
        space: insert(:space),
        person: insert(:person, is_admin: true)
      ]
    end

    test "get list of spaces without authentication", %{conn: conn} do
      response = graphql_query(conn, %{query: query()}, :success)
      assert Map.has_key?(response, "errors")
    end

    test "gets a space by id", %{conn: conn, space: space, person: person} do
      auth_conn = conn |> authorize(person)

      response = graphql_query(auth_conn, %{query: query()}, :success)
      assert response == %{"data" => %{"listSpaces" => [%{"id" => "#{space.id}", "openHours" => [%{"dayOfTheWeek" => "monday"}]}]}}
    end


    defp query do
      """
      query {
        listSpaces {
          id
          openHours {
            dayOfTheWeek
          }
        }
      }
      """
    end
  end
end
