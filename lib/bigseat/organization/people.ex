defmodule Bigseat.Organization.People do
  import Ecto.Query, warn: false
  alias Bigseat.Repo
  alias Bigseat.Core.Person

  def list(organization_id) do
    Person
    |> where(organization_id: ^organization_id)
    |> Repo.all()
  end
end
