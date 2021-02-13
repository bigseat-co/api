defmodule BigseatWeb.Schema.GetSpaceTest do
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

    test "get a space id without authentication", %{conn: conn, space: space} do
      response = graphql_query(conn, space.id |> query, :success)
      assert Map.has_key?(response, "errors")
    end

    test "gets a space by id", %{conn: conn, space: space, person: person} do
      auth_conn = conn |> put_req_header("authorization", "Bearer #{person.api_key}")

      response = graphql_query(auth_conn, space.id |> query, :success)
      assert response == %{"data" => %{"getSpace" => %{"id" => "#{space.id}"}}}
    end


    defp query(id) do
      """
      query {
        getSpace(id: "#{id}") {
          id
        }
      }
      """
    end
  end
end
