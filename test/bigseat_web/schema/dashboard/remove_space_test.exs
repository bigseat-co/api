defmodule BigseatWeb.Schema.RemoveSpaceTest do
  use BigseatWeb.ConnCase, async: true
  alias Bigseat.Factory.{
    OrganizationFactory,
    PersonFactory,
    SpaceFactory
  }
  use Bigseat.HelpersCase

  describe "remove space" do
    setup do
      organization = OrganizationFactory.insert(:organization)

      [
        space: SpaceFactory.insert(:space, %{organization: organization}),
        myself: PersonFactory.insert(:person, %{organization: organization, is_admin: true})
      ]
    end

    test "without authentication", %{conn: conn, space: space} do
      response = graphql_query(conn, %{query: query(), variables: %{id: space.id}}, :success)
      assert Map.has_key?(response, "errors")
    end

    test "with authentication", %{conn: conn, myself: myself, space: space} do
      auth_conn = conn |> authorize(myself)
      response = graphql_query(auth_conn, %{query: query(), variables: %{id: space.id}}, :success)
      assert response == %{"data" => %{"removeSpace" => %{"id" => space.id}}}
    end

    defp query() do
      """
      mutation removeSpace(
        $id: UUID4!
      ) {
        removeSpace(
          id: $id
        ) {
          id
        }
      }
      """
    end
  end
end