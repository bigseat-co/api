defmodule Bigseat.Schema.Dashboard.Queries.Spaces do
  use Absinthe.Schema.Notation

  object :dashboard_queries do
    @desc "Get a list of spaces"
    field :spaces, list_of(:space) do
      middleware BigseatWeb.Middleware.Authorized
      resolve fn _parent, _args, _resolution ->
        {:ok, Bigseat.Dashboard.Spaces.lists()}
      end
    end

    @desc "Get a specific space"
    field :space, :space do
      arg :id, non_null(:uuid)
      middleware BigseatWeb.Middleware.Authorized
      resolve fn _parent, %{id: id}, _resolution ->
        {:ok, Bigseat.Dashboard.Spaces.get!(id)}
      end
    end
  end
end
