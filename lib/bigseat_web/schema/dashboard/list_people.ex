defmodule Bigseat.Schema.Dashboard.ListPeople do
  use Absinthe.Schema.Notation
  alias Crudry.Middlewares.TranslateErrors

  object :dashboard_list_people do
    @desc "Get a list of people"
    field :list_people, list_of(:dashboard_person) do
      middleware BigseatWeb.Middleware.AuthorizedAdmin
      resolve &resolve/3
      middleware TranslateErrors
    end
  end

  def resolve(_parent, _args, %{ context: %{ myself: %{ organization_id: organization_id } }}) do
    {:ok, Bigseat.Organization.People.list(organization_id)}
  end

  def resolve(_parent, _args, _resolution) do
    {:error, "not found"}
  end
end
