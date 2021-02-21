defmodule Bigseat.Schema.Dashboard.RemoveTeamMember do
  use Absinthe.Schema.Notation
  alias Crudry.Middlewares.TranslateErrors

  object :dashboard_remove_team_member do
    @desc "Add a new team member to the organization"
    field :remove_team_member, :person do
      arg :id, non_null(:uuid)

      middleware BigseatWeb.Middleware.AuthorizedAdmin
      resolve fn _parent, %{ id: id }, %{ context: %{ current_person: current_person }} ->
        Bigseat.Dashboard.People.delete(id, current_person.organization_id)
      end
      middleware TranslateErrors
    end
  end
end
