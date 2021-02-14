defmodule BigseatWeb.Schema.CreateSpaceTest do
  use BigseatWeb.ConnCase, async: true
  import Bigseat.Factory
  use Bigseat.HelpersCase
  alias Bigseat.Dashboard.{
    Space
  }

  describe "create_space" do
    setup do
      [
        person: insert(:person, is_admin: true),
        # payload: %{} # not currently in use, can be transferred if complex data are needed
      ]
    end

    test "without authentication", %{conn: conn} do
      response = graphql_query(conn, %{query: query(), variables: variables()}, :success)
      assert Map.has_key?(response, "errors")
    end

    test "with authentication", %{conn: conn, person: person} do
      auth_conn = conn |> authorize(person)

      response = graphql_query(auth_conn, %{query: query(), variables: variables()}, :success)
      space_created = Space |> first() |> Repo.one()
      assert response == %{"data" => %{"createSpace" => %{"id" => space_created.id}}}
    end


    defp query() do
      """
      mutation createSpace(
        $openHours: OpenHoursInput!
      ) {
        createSpace(
          avatarUrl: "https://fake-image.com",
          name: "My space",
          openHours: $openHours,
          maximumPeople: 10
        ) {
          id
        }
      }
      """
    end

    def variables() do
      %{
        open_hours: [%{
          day_of_the_week: "monday",
          open_time: "10:59:40Z",
          close_time: "20:59:40Z"
        }]
      }
    end
  end
end