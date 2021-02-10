defmodule BigseatWeb.Schema.SignupTest do
  use BigseatWeb.ConnCase, async: true
  use Bigseat.HelpersCase
  alias Bigseat.Dashboard.{
    Person,
    Organization
  }

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
      mutation = signup |> valid_mutation
      response = conn |> graphql_query(mutation, :success)

      assert response == %{"data" => %{"signup" => %{"id" => first_person().id}}}
    end

    test "signup a new person with a specific organization slug", %{conn: conn, signup: signup} do
      mutation = signup |> valid_mutation_with_slug("valid-slug")
      response = conn |> graphql_query(mutation, :success)

      assert response == %{"data" => %{"signup" => %{"id" => first_person().id}}}
      assert first_organization().slug == "valid-slug"
    end

    defp first_person do
      Person |> first() |> Repo.one()
    end

    defp first_organization do
      Organization |> first() |> Repo.one()
    end

    defp valid_mutation(signup) do
      """
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
    end

    defp valid_mutation_with_slug(signup, slug) do
      """
      mutation {
        signup(
          email: "#{signup.email}"
          firstName: "#{signup.first_name}"
          lastName: "#{signup.last_name}"
          organization: {
            name: "#{signup.organization.name}"
            slug: "#{slug}"
          }
          password: "#{signup.password}"
        ) {
          id
        }
      }
      """
    end
  end
end
