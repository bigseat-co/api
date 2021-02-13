defmodule BigseatWeb.Schema.SpaceTest do
  use BigseatWeb.ConnCase, async: true
  import Bigseat.Factory
  use Bigseat.HelpersCase
  alias Bigseat.Dashboard.{
    Person,
    Organization
  }

  describe "spaces" do
    setup do
      insert(:person)
      [space: insert(:space)]
    end

    test "get a space id without authentication", %{conn: conn, space: %{id: id}} do
      response = graphql_query(conn, query(id), :success)
      assert Map.has_key?(response, "errors")
    end

    test "gets a space by id", %{conn: conn, space: %{id: id}} do
      auth_conn = conn |> put_req_header("authorization", "Bearer #{first_person().api_key}")

      response = graphql_query(auth_conn, query(id), :success)
      assert response == %{"data" => %{"space" => %{"id" => "#{id}"}}}
    end

    defp first_person do
      Person |> first() |> Repo.one()
    end

    defp query(id) do
      """
      query {
        space(id: "#{id}") {
          id
        }
      }
      """
    end
  end
end
