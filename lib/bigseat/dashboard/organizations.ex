defmodule Bigseat.Dashboard.Organizations do

  import Ecto.Query, warn: false
  alias Bigseat.Repo

  alias Bigseat.Dashboard.Organization

  def list do
    Repo.all(Organization)
  end

  def get_organization!(id), do: Repo.get!(Organization, id)

  def create(attrs \\ %{}) do
    %Organization{}
    |> Organization.changeset(attrs)
    |> Repo.insert()
  end

  def update(%Organization{} = organization, attrs) do
    organization
    |> Organization.changeset(attrs)
    |> Repo.update()
  end

  def delete(%Organization{} = organization) do
    Repo.delete(organization)
  end

  def change(%Organization{} = organization, attrs \\ %{}) do
    Organization.changeset(organization, attrs)
  end
end
