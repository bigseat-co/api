defmodule Bigseat.Schema.Dashboard.Types do
  use Absinthe.Schema.Notation

  object :space do
    field :id, :uuid
    field :organization_id, :id
    field :avatar_url, :string
    field :name, :string
    field :slug, :string
    field :working_days, :json
    field :open_hours, :json
  end

  object :person do
    field :id, :uuid
    field :first_name, :string
    field :last_name, :string
    field :email, :string
    field :password, :string
    field :api_key, :string
    field :organization, :organization
  end

  object :organization do
    field :id, :uuid
    field :name, :string
    field :slug, :string
  end
end
