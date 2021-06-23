defmodule Bigseat.Schema.Dashboard.RemoveSpace do
  import Ecto.Query, warn: false
  use Absinthe.Schema.Notation
  alias Bigseat.Repo
  alias Crudry.Middlewares.TranslateErrors
  alias Bigseat.Core.Space

  object :dashboard_remove_space do
    @desc "Remove a space from the organization"
    field :remove_space, :dashboard_space do
      arg :id, non_null(:uuid)

      middleware BigseatWeb.Middleware.AuthorizedAdmin
      resolve &resolve/3
      middleware TranslateErrors
    end
  end

  def resolve(_parent, %{ id: id }, %{ context: %{ myself: %{ organization_id: organization_id } }}) do
    space = Space |> where(id: ^id) |> where(organization_id: ^organization_id) |> Repo.one()
    case space do
      %Space{} ->
        Bigseat.Core.Spaces.delete(space)
        {:ok, space} # return deleted resource
      _ -> {:error, "space not found"}
    end
  end

  def resolve(_parent, _args, _resolution) do
    {:error, "not found"}
  end
end
