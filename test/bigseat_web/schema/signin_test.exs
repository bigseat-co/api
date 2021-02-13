defmodule BigseatWeb.Schema.SigninTest do
  use BigseatWeb.ConnCase, async: true
  import Bigseat.Factory
  use Bigseat.HelpersCase
  alias Bigseat.Dashboard.{
    Person,
    Organization
  }

  describe "spaces" do
    setup do
      [space: insert(:person, %{
        email: "test@test.com",
        encrypted_password: Comeonin.Bcrypt.hashpwsalt("Password0$")
        })
      ]

      [signin: %{
        email: "test@test.com",
        password: "Password0$"
      }]
    end

    test "signin a new person", %{conn: conn, signin: signin} do
      mutation = signin |> valid_mutation
      response = conn |> graphql_query(mutation, :success)

      require IEx; IEx.pry
      assert response == %{"data" =>
        %{"signin" =>
          %{
            "id" => first_person().id,
            "organization" => %{
              "api_key" => first_organization().api_key
              }
            }
          }
        }
    end

    defp first_person do
      Person |> first() |> Repo.one()
    end

    defp first_organization do
      Organization |> first() |> Repo.one()
    end

    defp valid_mutation(signin) do
      """
      mutation {
        signin(
          email: "#{signin.email}"
          password: "#{signin.password}"
        ) {
          api_key
        }
      }
      """
    end
  end
end
