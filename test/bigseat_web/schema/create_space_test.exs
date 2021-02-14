# defmodule BigseatWeb.Schema.CreateSpaceTest do
#   use BigseatWeb.ConnCase, async: true
#   import Bigseat.Factory
#   use Bigseat.HelpersCase

#   describe "get_space" do
#     setup do
#       [
#         person: insert(:person),
#         payload: %{
#             email: "test@test.com",
#           first_name: "Laurent",
#           last_name: "Schaffner",
#           organization: %{
#               name: "BigSeat"
#           },
#           password: "Password0$"
#         }
#       ]
#     end

#     test "create a space without authentication", %{conn: conn} do
#       response = graphql_query(conn, %{query: space |> query()}, :success)
#       assert Map.has_key?(response, "errors")
#     end

#     test "gets a space by id", %{conn: conn, space: space, person: person} do
#       auth_conn = conn |> put_req_header("authorization", "Bearer #{person.api_key}")

#       response = graphql_query(auth_conn, %{query: space.id |> query}, :success)
#       assert response == %{"data" => %{"getSpace" => %{"id" => "#{space.id}"}}}
#     end


#     defp query(id) do
#       """
#       query {
#         getSpace(id: "#{id}") {
#           id
#         }
#       }
#       """
#     end
#   end
# end
