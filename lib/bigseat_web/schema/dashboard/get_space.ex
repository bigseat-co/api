defmodule Bigseat.Schema.Dashboard.GetSpace do
  use Absinthe.Schema.Notation

  object :dashboard_get_space do
    @desc "Get a specific space"
    field :get_space, :space do
      arg :id, non_null(:uuid)

      resolve fn _parent, %{id: id}, _resolution ->
        {:ok, Bigseat.Dashboard.Spaces.get!(id)}
      end
    end
  end
end
