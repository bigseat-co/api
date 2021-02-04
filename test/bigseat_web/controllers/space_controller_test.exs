defmodule BigseatWeb.SpaceControllerTest do
  use BigseatWeb.ConnCase

  alias Bigseat.Core
  alias Bigseat.Core.Space

  @create_attrs %{
    avatar_url: "some avatar_url",
    name: "some name",
    open_hours: %{},
    slug: "some slug",
    working_days: %{}
  }
  @update_attrs %{
    avatar_url: "some updated avatar_url",
    name: "some updated name",
    open_hours: %{},
    slug: "some updated slug",
    working_days: %{}
  }
  @invalid_attrs %{avatar_url: nil, name: nil, open_hours: nil, slug: nil, working_days: nil}

  def fixture(:space) do
    {:ok, space} = Core.create_space(@create_attrs)
    space
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all spaces", %{conn: conn} do
      conn = get(conn, Routes.space_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create space" do
    test "renders space when data is valid", %{conn: conn} do
      conn = post(conn, Routes.space_path(conn, :create), space: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.space_path(conn, :show, id))

      assert %{
               "id" => id,
               "avatar_url" => "some avatar_url",
               "name" => "some name",
               "open_hours" => %{},
               "slug" => "some slug",
               "working_days" => %{}
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.space_path(conn, :create), space: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update space" do
    setup [:create_space]

    test "renders space when data is valid", %{conn: conn, space: %Space{id: id} = space} do
      conn = put(conn, Routes.space_path(conn, :update, space), space: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.space_path(conn, :show, id))

      assert %{
               "id" => id,
               "avatar_url" => "some updated avatar_url",
               "name" => "some updated name",
               "open_hours" => %{},
               "slug" => "some updated slug",
               "working_days" => %{}
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, space: space} do
      conn = put(conn, Routes.space_path(conn, :update, space), space: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete space" do
    setup [:create_space]

    test "deletes chosen space", %{conn: conn, space: space} do
      conn = delete(conn, Routes.space_path(conn, :delete, space))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.space_path(conn, :show, space))
      end
    end
  end

  defp create_space(_) do
    space = fixture(:space)
    %{space: space}
  end
end
