defmodule Bigseat.Schema.Dashboard.AddNewTeamMember do
  use Absinthe.Schema.Notation
  alias Crudry.Middlewares.TranslateErrors
  alias Bigseat.Repo
  alias Bigseat.Dashboard.Organization

  object :dashboard_add_new_team_member do
    @desc "Add a new team member to the organization"
    field :add_new_team_member, :person do
      arg :first_name, non_null(:string)
      arg :last_name, non_null(:string)
      arg :email, non_null(:string)
      arg :group, non_null(:string)

      middleware BigseatWeb.Middleware.AuthorizedAdmin
      resolve fn _parent, args, %{ context: %{ current_person: %{ organization_id: organization_id }}} ->
        Bigseat.Dashboard.People.create_for_organization(args, organization_id)
      end
      middleware TranslateErrors
    end
  end
end
