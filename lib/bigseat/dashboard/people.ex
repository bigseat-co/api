defmodule Bigseat.Dashboard.People do
  import Ecto.Query, warn: false
  alias Bigseat.Mailer
  alias Bigseat.Repo
  alias Ecto.Multi

  alias Bigseat.Dashboard.{
    Person,
    Organization,
    PeoplePasswordToken
  }

  def list do
    Repo.all(Person)
  end

  def get!(id), do: Repo.get!(Person, id)

  def create_from_scratch(params = %{ organization: organization_params } \\ %{}) do
    organization_changeset = %Organization{}
    |> Organization.changeset(organization_params)

    # those are default attributes
    # when you create from scratch
    person_characteristics = %{
      is_admin: true,
      group: :office,
      type: "TeamMember"
    }

    multi = Multi.new
    |> Multi.insert(:organization, organization_changeset)
    |> Multi.run(:person, fn _repo, %{organization: organization} ->
      %Person{}
      |> Person.create_changeset(Map.merge(person_characteristics, Map.delete(params, :organization)))
      |> Ecto.Changeset.put_assoc(:organization, organization)
      |> Repo.insert()
    end)

    case Repo.transaction(multi) do
      {:ok, %{person: person}} -> {:ok, person}
      {:error, _model, changeset, _changes_so_far} -> {:error, changeset}
    end
  end

  def create_for_organization(params \\ %{}, organization_id) do
    organization = Organization |> Repo.get!(organization_id)

    # it's a team member but he has no admin power
    # the group must be defined by hand
    person_characteristics = %{
      is_admin: false,
      type: "TeamMember"
    }

    %Person{}
    |> Person.create_changeset(Map.merge(person_characteristics, params))
    |> Ecto.Changeset.put_assoc(:organization, organization)
    |> Repo.insert()
  end

  def update(%Person{} = person, params) do
    person
    |> Person.update_changeset(params)
    |> Repo.update()
  end

  def delete(%Person{} = person) do
    Repo.delete(person)
  end

  def change(%Person{} = person, params \\ %{}) do
    Person.changeset(person, params)
  end
end
