defmodule BigseatWeb.Schema.ListPeopleTest do
  use BigseatWeb.ConnCase, async: true
  alias Bigseat.Factory.{
    OrganizationFactory,
    PersonFactory
  }
  use Bigseat.HelpersCase

  describe "list people" do
    setup do
      organization = OrganizationFactory.insert(:organization)

      [

        myself: PersonFactory.insert(:person, %{organization: organization, is_admin: true})
      ]
    end

    test "without authentication", %{conn: conn} do
      response = graphql_query(conn, %{query: query()}, :success)
      assert Map.has_key?(response, "errors")
    end

    test "with authentication", %{conn: conn, myself: myself} do
      auth_conn = conn |> authorize(myself)

      response = graphql_query(auth_conn, %{query: query()}, :success)
      assert response == %{"data" => %{"listPeople" => [%{"id" => myself.id, "email" => myself.email, "firstName" => myself.first_name, "lastName" => myself.last_name}]}}
    end

    test "filter out people outside of current organization", %{conn: conn, myself: myself} do
      PersonFactory.insert(:person)

      auth_conn = conn |> authorize(myself)

      response = graphql_query(auth_conn, %{query: query()}, :success)
      assert response == %{"data" => %{"listPeople" => [%{"id" => myself.id, "email" => myself.email, "firstName" => myself.first_name, "lastName" => myself.last_name}]}}
    end

    defp query do
      """
      query {
        listPeople {
          id
          email
          firstName
          lastName
        }
      }
      """
    end
  end
end
