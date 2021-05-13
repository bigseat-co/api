defmodule BigseatWeb.Schema.ListSpacesTest do
  use BigseatWeb.ConnCase, async: true
  alias Bigseat.Factory.{
    OrganizationFactory,
    PersonFactory,
    SpaceFactory
  }
  use Bigseat.HelpersCase

  describe "list spaces" do
    setup do
      organization = OrganizationFactory.insert(:organization)

      [
        space: SpaceFactory.insert(:space, %{organization: organization}),
        myself: PersonFactory.insert(:person, %{organization: organization, is_admin: true})
      ]
    end

    test "without authentication", %{conn: conn} do
      response = graphql_query(conn, %{query: query()}, :success)
      assert Map.has_key?(response, "errors")
    end

    test "with authentication", %{conn: conn, space: space, myself: myself} do
      auth_conn = conn |> authorize(myself)

      response = graphql_query(auth_conn, %{query: query()}, :success)
      assert response == %{"data" => %{"listSpaces" => [%{"id" => "#{space.id}", "openHours" => [%{"dayOfTheWeek" => "monday"}]}]}}
    end

    test "filter out spaces outside of current organization", %{conn: conn, space: space, myself: myself} do
      SpaceFactory.insert(:space)

      auth_conn = conn |> authorize(myself)

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
