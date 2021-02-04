defmodule BigseatWeb.SpaceController do
  use BigseatWeb, :controller

  alias Bigseat.Core
  alias Bigseat.Core.Space

  action_fallback BigseatWeb.FallbackController

  def index(conn, _params) do
    spaces = Core.list_spaces()
    render(conn, "index.json", spaces: spaces)
  end

  def create(conn, %{"space" => space_params}) do
    with {:ok, %Space{} = space} <- Core.create_space(space_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.space_path(conn, :show, space))
      |> render("show.json", space: space)
    end
  end

  def show(conn, %{"id" => id}) do
    space = Core.get_space!(id)
    render(conn, "show.json", space: space)
  end

  def update(conn, %{"id" => id, "space" => space_params}) do
    space = Core.get_space!(id)

    with {:ok, %Space{} = space} <- Core.update_space(space, space_params) do
      render(conn, "show.json", space: space)
    end
  end

  def delete(conn, %{"id" => id}) do
    space = Core.get_space!(id)

    with {:ok, %Space{}} <- Core.delete_space(space) do
      send_resp(conn, :no_content, "")
    end
  end
end
