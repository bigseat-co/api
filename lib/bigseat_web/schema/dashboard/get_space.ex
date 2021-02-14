defmodule Bigseat.Schema.Dashboard.GetSpace do
  use Absinthe.Schema.Notation
  alias Crudry.Middlewares.TranslateErrors

  object :dashboard_get_space do
    @desc "Get a specific space"
    field :get_space, :space do
      arg :id, non_null(:uuid)

      middleware BigseatWeb.Middleware.AuthorizedAdmin
      resolve fn _parent, %{id: id}, _resolution ->
        {:ok, Bigseat.Dashboard.Spaces.get!(id)}
      end
      middleware TranslateErrors
    end
  end
end
