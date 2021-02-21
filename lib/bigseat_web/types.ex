defmodule Bigseat.Schema.Types do
  use Absinthe.Schema.Notation

  object :space do
    field :id, :uuid
    field :organization_id, :id
    field :avatar_url, :string
    field :name, :string
    field :slug, :string
    field :maximum_people, :integer
    field :open_hours, list_of(:space_open_hours)
  end

  object :space_open_hours do
    field :id, :uuid
    field :space_id, :id
    field :day_of_the_week, :string
    field :open_time, :time
    field :close_time, :time
  end

  # NOTE : be careful with sensitive data, if we call those from a public area,
  # we should add resolvers and restriction depending the context, and change the types called
  object :person do
    field :id, :uuid
    field :first_name, :string
    field :last_name, :string
    field :email, :string
    field :password, :string
    field :api_key, :string
    field :organization, :organization
    field :password_recovery_token, :string
  end

  object :organization do
    field :id, :uuid
    field :name, :string
    field :slug, :string
  end
end
