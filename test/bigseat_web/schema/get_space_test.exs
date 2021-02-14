defmodule BigseatWeb.Schema.GetSpaceTest do
  use BigseatWeb.ConnCase, async: true
  import Bigseat.Factory
  use Bigseat.HelpersCase

  describe "get_space" do
    setup do
      [
        space: insert(:space),
        # person: insert(:person)
      ]
    end

    # test "without authentication", %{conn: conn, space: space} do
    #   response = graphql_query(conn, %{query: query(), variables: space |> variables()}, :success)
    #   assert Map.has_key?(response, "errors")
    # end

    test "by id", %{conn: conn, space: space} do
      # auth_conn = conn |> authorize(person)

      response = graphql_query(conn, %{query: query(), variables: space |> variables()}, :success)
      assert response == %{"data" => %{"getSpace" => %{"id" => "#{space.id}"}}}
    end

    defp query() do
      """
      query(
        $id: UUID4!
      ) {
        getSpace(id: $id) {
          id
        }
      }
      """
    end

    def variables(space) do
      %{
        id: space.id
      }
    end
  end
end
