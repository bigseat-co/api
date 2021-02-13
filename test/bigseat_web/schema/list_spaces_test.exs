defmodule BigseatWeb.Schema.ListSpacesTest do
  use BigseatWeb.ConnCase, async: true
  import Bigseat.Factory
  use Bigseat.HelpersCase
  alias Bigseat.Dashboard.{
    Person,
    Organization
  }

  describe "get_space" do
    setup do
      [
        space: insert(:space),
        person: insert(:person)
      ]
    end

    test "get list of spaces without authentication", %{conn: conn, space: space} do
      response = graphql_query(conn, query, :success)
      assert Map.has_key?(response, "errors")
    end

    test "gets a space by id", %{conn: conn, space: space, person: person} do
      auth_conn = conn |> put_req_header("authorization", "Bearer #{person.api_key}")

      response = graphql_query(auth_conn, query, :success)
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
