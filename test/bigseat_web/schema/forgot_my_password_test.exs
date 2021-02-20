# defmodule BigseatWeb.Schema.ForgotMyPasswordTest do
#   use BigseatWeb.ConnCase, async: true
#   import Bigseat.Factory
#   use Bigseat.HelpersCase
#   alias Bigseat.Dashboard.{
#     Person
#   }

#   describe "forgot_my_password" do
#     setup do
#       [
#         person: insert(:person, is_admin: true, email: "existing-email@gmail.com"),
#       ]
#     end

#     test "with existing email", %{conn: conn} do
#       response = graphql_query(conn, %{query: query(), variables: %{email: "existing-email@gmail.com"}}, :success)
#       person_created = Person |> where(is_admin: true) |> first() |> Repo.one()
#       assert response == %{"data" => %{"forgotMyPassword" => %{"email" => person_created.email}}}
#     end

#     test "with non existing email", %{conn: conn} do
#       response = graphql_query(conn, %{query: query(), variables: %{email: "wrong-email@gmail.com"}}, :success)
#       person_created = Person |> where(is_admin: true) |> first() |> Repo.one()
#       assert response == %{"data" => %{"forgotMyPassword" => %{"email" => "wrong-email@gmail.com"}}}
#     end

#     defp query() do
#       """
#       mutation forgotMyPassword(
#         $email: String!
#       ) {
#         forgotMyPassword(
#           email: $email
#         ) {
#           email
#         }
#       }
#       """
#     end

#     def variables() do
#       %{
#         email: "existing@email.com",
#       }
#     end
#   end
# end
