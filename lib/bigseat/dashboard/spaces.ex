defmodule Bigseat.Dashboard.Spaces do

  import Ecto.Query, warn: false
  alias Bigseat.Repo

  alias Bigseat.Dashboard.Space

  def lists do
    Repo.all(Space)
  end

  def get!(id), do: Repo.get!(Space, id)

  def create(attrs \\ %{}) do
    %Space{}
    |> Space.changeset(attrs)
    |> Repo.insert()
  end

  def update(%Space{} = space, attrs) do
    space
    |> Space.changeset(attrs)
    |> Repo.update()
  end

  def delete(%Space{} = space) do
    Repo.delete(space)
  end

  def change(%Space{} = space, attrs \\ %{}) do
    Space.changeset(space, attrs)
  end
end
