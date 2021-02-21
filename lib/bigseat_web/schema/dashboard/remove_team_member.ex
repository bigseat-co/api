defmodule Bigseat.Schema.Dashboard.RemoveTeamMember do
  import Ecto.Query, warn: false
  use Absinthe.Schema.Notation
  alias Bigseat.Repo
  alias Crudry.Middlewares.TranslateErrors
  alias Bigseat.Core.Person

  object :dashboard_remove_team_member do
    @desc "Remove a team member from the organization"
    field :remove_team_member, :dashboard_person do
      arg :id, non_null(:uuid)

      middleware BigseatWeb.Middleware.AuthorizedAdmin
      resolve &resolve/3
      middleware TranslateErrors
    end
  end

  def resolve(_parent, %{ id: id }, %{ context: %{ current_person: %{ organization_id: organization_id } }}) do
    person = Person |> where(id: ^id) |> where(organization_id: ^organization_id) |> Repo.one()
    case person do
      %Person{} -> Bigseat.Core.People.delete(person)
      _ -> {:error, "not found"}
    end
  end

  def resolve(_parent, _args, _resolution) do
    {:error, "not found"}
  end
end
