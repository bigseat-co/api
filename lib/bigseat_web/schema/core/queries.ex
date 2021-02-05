defmodule Bigseat.Schema.Core.Queries do
  use Absinthe.Schema.Notation

  object :space_queries do
    @desc "Get a list of spaces"
    field :spaces, list_of(:space) do
      resolve fn _parent, _args, _resolution ->
        {:ok, Bigseat.Core.list_spaces()}
      end
    end
  end
end
