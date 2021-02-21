defmodule BigseatWeb.Schema.RemoveTeamMemberTest do
  use BigseatWeb.ConnCase, async: true
  alias Bigseat.Factory.PersonFactory
  use Bigseat.HelpersCase
  alias Bigseat.Dashboard.{
    Person
  }

  describe "add_new_team_member" do
    setup do
      person = PersonFactory.insert(:person, is_admin: true)
      [
        person: person,
        other_team_member: PersonFactory.insert(:person, organization_id: person.organization_id)
      ]
    end

    test "without authentication", %{conn: conn, person: person, other_team_member: other_team_member} do
      response = graphql_query(conn, %{query: query(), variables: %{id: other_team_member.id}}, :success)
      assert Map.has_key?(response, "errors")
    end

    test "with authentication", %{conn: conn, person: person, other_team_member: other_team_member} do
      auth_conn = conn |> authorize(person)
      response = graphql_query(auth_conn, %{query: query(), variables: %{id: other_team_member.id}}, :success)
      assert response == %{"data" => %{"removeTeamMember" => %{"id" => other_team_member.id}}}
    end

    defp query() do
      """
      mutation removeTeamMember(
        $id: UUID4!
      ) {
        removeTeamMember(
          id: $id
        ) {
          id
        }
      }
      """
    end
  end
end
