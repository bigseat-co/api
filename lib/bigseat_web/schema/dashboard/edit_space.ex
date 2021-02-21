defmodule Bigseat.Schema.Dashboard.EditSpace do
  import Ecto.Query, warn: false
  use Absinthe.Schema.Notation
  alias Crudry.Middlewares.TranslateErrors
  alias Bigseat.Dashboard.Space
  alias Bigseat.Repo

  object :dashboard_edit_space do
    @desc "Edit a specific space"
    field :edit_space, :space do
      arg :id, :uuid
      arg :space_input, non_null(:space_input)

      middleware BigseatWeb.Middleware.AuthorizedAdmin
      resolve &resolve/3
      middleware TranslateErrors
    end
  end

  input_object :space_input do
    field :avatar_url, :string
    field :slug, :string
    field :name, :string
    field :open_hours, list_of(:open_hours_input)
    field :maximum_people, :integer
  end

  def resolve(_parent, %{ id: id, space_input: space_input }, %{ context: %{ current_person: %{ organization_id: organization_id }}}) do
    space = Space |> where(id: ^id) |> where(organization_id: ^organization_id) |> Repo.one()
    case space do
      %Space{} -> Bigseat.Dashboard.Spaces.update(space, space_input)
      _ -> {:error, "not found"}
    end
  end

  def resolve(_parent, _args, _resolution) do
    {:error, "not found"}
  end
end
