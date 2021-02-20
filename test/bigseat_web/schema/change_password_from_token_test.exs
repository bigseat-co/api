defmodule BigseatWeb.Schema.ChangePasswordFromTokenTest do
  use BigseatWeb.ConnCase, async: true
  import Bigseat.Factory
  use Bigseat.HelpersCase
  alias Bigseat.Dashboard.{
    Person
  }

  describe "change_password_from_token" do
    setup do
      [
        person: insert(:person, is_admin: true),
      ]
    end

    test "with non existing token", %{conn: conn, person: person} do
      response = conn |> graphql_query(%{query: query(), variables: %{token: "wrong-token"}}, :success)
      assert Map.has_key?(response, "errors")
    end

    test "with non existing email", %{conn: conn, person: person} do
      people_person_token = insert(:people_password_token, person: person)
      response = conn |> graphql_query(%{query: query(), variables: %{token: people_person_token.token, new_password: "random-password"}}, :success)
      assert response == %{"data" => %{"changePasswordFromToken" => %{"id" => person.id}}}
    end

    defp query() do
      """
      mutation changePasswordFromToken(
        $token: String!
        $newPassword: String!
      ) {
        changePasswordFromToken(
          token: $token
          newPassword: $newPassword
        ) {
          id
        }
      }
      """
    end
  end
end
