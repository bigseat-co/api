defmodule Bigseat.Schema.Core.Queries do
  use Absinthe.Schema.Notation

  object :space_queries do
    @desc "Get a list of spaces"
    field :spaces, list_of(:space) do
      resolve fn _parent, _args, _resolution ->
        {:ok, Bigseat.Core.list_spaces()}
      end
    end

    @desc "Get a specific space"
    field :space, :space do
      arg :id, non_null(:uuid)
      resolve fn _parent, %{id: id}, _resolution ->
        {:ok, Bigseat.Core.get_space!(id)}
      end
    end
  end
end
