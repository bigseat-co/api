defmodule Bigseat.Dashboard.Spaces do
  alias Bigseat.Repo
  alias Ecto.Multi

  alias Bigseat.Dashboard.{
    Space,
    SpaceOpenHour
  }

  def lists do
    Space |> Repo.all() |> Repo.preload(:open_hours)
  end

  def get!(id), do: Repo.get!(Space, id)

  def create(params = %{ open_hours: open_hours_params }, organization_id) do
    space_params = Map.delete(params, :open_hours) |> Map.merge(%{organization_id: organization_id})
    changeset = %Space{} |> Space.changeset(space_params)

    multi = Multi.new
    |> Multi.insert(:space, changeset)
    |> Multi.run(:open_hours, fn _repo, %{space: space} ->
      open_hours = Enum.each open_hours_params, fn open_hour_param ->
        %SpaceOpenHour{}
        |> SpaceOpenHour.changeset(open_hour_param)
        |> Ecto.Changeset.put_assoc(:space, space)
        |> Repo.insert()
      end
      {:ok, open_hours}
    end)

    case Repo.transaction(multi) do
      {:ok, %{space: space}} -> {:ok, space}
      {:error, _model, changeset, _changes_so_far} -> {:error, changeset}
    end
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
