defmodule BigseatWeb.SpaceView do
  use BigseatWeb, :view
  alias BigseatWeb.SpaceView

  def render("index.json", %{spaces: spaces}) do
    %{data: render_many(spaces, SpaceView, "space.json")}
  end

  def render("show.json", %{space: space}) do
    %{data: render_one(space, SpaceView, "space.json")}
  end

  def render("space.json", %{space: space}) do
    %{id: space.id,
      slug: space.slug,
      name: space.name,
      working_days: space.working_days,
      open_hours: space.open_hours,
      avatar_url: space.avatar_url}
  end
end
