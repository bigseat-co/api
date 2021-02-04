defmodule Bigseat.Schema.DataTypes do
  use Absinthe.Schema.Notation

  object :space do
    field :id, :id
    field :organization_id, :id
    field :avatar_url, :string
    field :name, :string
    field :slug, :string
    # field :working_days, :map
    # field :open_hours, :map
  end
end
