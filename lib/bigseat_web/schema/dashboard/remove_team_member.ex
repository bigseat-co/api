defmodule Bigseat.Schema.Dashboard.RemoveTeamMember do
  import Ecto.Query, warn: false
  use Absinthe.Schema.Notation
  alias Bigseat.Repo
  alias Crudry.Middlewares.TranslateErrors
  alias Bigseat.Dashboard.Person

  object :dashboard_remove_team_member do
    @desc "Remove a team member from the organization"
    field :remove_team_member, :person do
      arg :id, non_null(:uuid)

      middleware BigseatWeb.Middleware.AuthorizedAdmin
      resolve fn _parent, %{ id: id }, %{ context: %{ current_person: current_person }} ->
        organization_id = current_person.organization_id
        person = Person |> where(id: ^id) |> where(organization_id: ^organization_id) |> Repo.one()
        case person do
          %Person{} -> Bigseat.Dashboard.People.delete(person)
          _ -> {:error, "not found"}
        end
      end
      middleware TranslateErrors
    end
  end
end
