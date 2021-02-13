defmodule Bigseat.Dashboard.People do
  alias Bigseat.Repo
  alias Ecto.Multi

  alias Bigseat.Dashboard.{
    Person,
    Organization
  }

  def list do
    Repo.all(Person)
  end

  def get!(id), do: Repo.get!(Person, id)

  def create(params = %{ organization: organization_params } \\ %{}) do
    organization_changeset = %Organization{}
    |> Organization.changeset(organization_params)

    multi = Multi.new
    |> Multi.insert(:organization, organization_changeset)
    |> Multi.run(:person, fn _repo, %{organization: organization} ->
      %Person{}
      |> Person.changeset(Map.merge(%{is_admin: true}, Map.delete(params, :organization)))
      |> Ecto.Changeset.put_assoc(:organization, organization)
      |> Repo.insert()
    end)

    case Repo.transaction(multi) do
      {:ok, %{person: person}} -> {:ok, person}
      {:error, _model, changeset, _changes_so_far} -> {:error, changeset}
    end
  end

  def update(%Person{} = person, params) do
    person
    |> Person.changeset(params)
    |> Repo.update()
  end

  def delete(%Person{} = person) do
    Repo.delete(person)
  end

  def change(%Person{} = person, params \\ %{}) do
    Person.changeset(person, params)
  end
end
