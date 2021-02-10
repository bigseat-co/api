defmodule BigseatWeb.Schema.SignupTest do
  use BigseatWeb.ConnCase, async: true
  use Bigseat.HelpersCase
  alias Bigseat.Dashboard.Person

  describe "spaces" do
    setup do
      [signup: %{
        email: "test@test.com",
        first_name: "Laurent",
        last_name: "Schaffner",
        organization: %{
          name: "BigSeat"
        },
        password: "Password0$"
      }]
    end

    test "signup a new person", %{conn: conn, signup: signup} do
      mutation = """
      mutation {
        signup(
          email: "#{signup.email}"
          firstName: "#{signup.first_name}"
          lastName: "#{signup.last_name}"
          organization: {
            name: "#{signup.organization.name}"
          }
          password: "#{signup.password}"
        ) {
          id
        }
      }
      """

      response = graphql_query(conn, mutation, :success)
      created_person = Person |> first() |> Repo.one()
      assert response == %{"data" => %{"signup" => %{"id" => created_person.id}}}
    end
  end
end
