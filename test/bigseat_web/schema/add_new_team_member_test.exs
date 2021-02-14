defmodule BigseatWeb.Schema.AddNewTeamMemberTest do
  use BigseatWeb.ConnCase, async: true
  import Bigseat.Factory
  use Bigseat.HelpersCase
  alias Bigseat.Dashboard.{
    Person
  }

  describe "add_new_team_member" do
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

    test "with authentication and a taken email", %{conn: conn, person: person} do
      auth_conn = conn |> authorize(person)

      response = graphql_query(auth_conn, %{query: query(), variables: variables() |> Map.merge(%{email: person.email})}, :success)
      assert Map.has_key?(response, "errors")
    end

    test "with authentication and a free email", %{conn: conn, person: person} do
      auth_conn = conn |> authorize(person)

      response = graphql_query(auth_conn, %{query: query(), variables: variables()}, :success)
      person_created = Person |> first() |> Repo.one()
      assert response == %{"data" => %{"addNewTeamMember" => %{"id" => person_created.id}}}
    end

    defp query() do
      """
      mutation addNewTeamMember(
        $email: String!
        $firstName: String!
        $lastName: String!
        $group: String!
      ) {
        addNewTeamMember(
          email: $email
          firstName: $firstName
          lastName: $lastName
          group: $group
        ) {
          id
        }
      }
      """
    end

    def variables() do
      %{
        email: "random@email.com",
        first_name: "Laurent",
        last_name: "Schaffner",
        group: "remote"
      }
    end
  end
end
