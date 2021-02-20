defmodule BigseatWeb.Schema.EditMyAccountTest do
  use BigseatWeb.ConnCase, async: true
  import Bigseat.Factory
  use Bigseat.HelpersCase
  alias Bigseat.Dashboard.{
    Person
  }

  describe "edit_my_account" do
    setup do
      [
        person: insert(:person, is_admin: true),
      ]
    end

    test "without authentication", %{conn: conn} do
      response = graphql_query(conn, %{query: query(), variables: variables()}, :success)
      assert Map.has_key?(response, "errors")
    end

    test "with authentication", %{conn: conn, person: person} do
      auth_conn = conn |> authorize(person)

      response = graphql_query(auth_conn, %{query: query(), variables: variables()}, :success)
      assert response == %{"data" => %{"editMyAccount" => %{"id" => person.id, "firstName" => "Lorenzo", "lastName" => "Schaffnero"}}}
    end

    defp query() do
      """
      mutation editMyAccount(
        $email: String
        $firstName: String
        $lastName: String
      ) {
        editMyAccount(
          email: $email
          firstName: $firstName
          lastName: $lastName
        ) {
          id
          firstName
          lastName
        }
      }
      """
    end

    def variables() do
      %{
        email: "new-email@gmail.com",
        first_name: "Lorenzo",
        last_name: "Schaffnero",
      }
    end
  end
end
