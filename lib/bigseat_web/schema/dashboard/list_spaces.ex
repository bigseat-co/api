defmodule Bigseat.Schema.Dashboard.ListSpaces do
  use Absinthe.Schema.Notation

  object :dashboard_list_spaces do
    @desc "Get a list of spaces"
    field :list_spaces, list_of(:space) do
      middleware BigseatWeb.Middleware.Authorized
      resolve fn _parent, _args, _resolution ->
        {:ok, Bigseat.Dashboard.Spaces.lists()}
      end
    end
  end
end