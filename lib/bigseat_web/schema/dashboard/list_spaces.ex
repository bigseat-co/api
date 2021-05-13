defmodule Bigseat.Schema.Dashboard.ListSpaces do
  use Absinthe.Schema.Notation
  alias Crudry.Middlewares.TranslateErrors
  alias Bigseat.Repo
  alias Bigseat.Core.Organization

  object :dashboard_list_spaces do
    @desc "Get a list of spaces"
    field :list_spaces, list_of(:dashboard_space) do
      middleware BigseatWeb.Middleware.AuthorizedAdmin
      resolve &resolve/3
      middleware TranslateErrors
    end
  end

  def resolve(_parent, _args, %{ context: %{ myself: %{ organization_id: organization_id } }}) do
    organization = Organization |> Repo.get(organization_id)
    case organization do
      %Organization{} -> {:ok, Bigseat.Core.Spaces.list(organization)}
      _ -> {:error, "organization not found"}
    end
  end

  def resolve(_parent, _args, _resolution) do
    {:error, "not found"}
  end
end
