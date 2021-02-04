defmodule Bigseat.Schema do
  use Absinthe.Schema

  import_types Bigseat.Schema.DataTypes

  query do
    @desc "Get a list of spaces"
    field :spaces, list_of(:space) do
      resolve fn _parent, _args, _resolution ->
        {:ok, Bigseat.Core.list_spaces()}
      end
    end
  end
end
