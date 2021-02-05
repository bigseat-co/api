defmodule Bigseat.Core.Space do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "spaces" do
    belongs_to :organization, Bigseat.Core.Organization
    field :avatar_url, :string
    field :name, :string
    field :slug, :string
    field :working_days, :map
    field :open_hours, :map

    timestamps()
  end

  @spec changeset(any, any) :: none
  @doc false
  def changeset(space, attrs) do
    space
    |> cast(attrs, [:slug, :name, :working_days, :open_hours, :avatar_url])
    |> validate_required([:slug, :name, :working_days, :open_hours, :avatar_url])
    |> unique_constraint(:slug, [:organization_id, :slug])
  end
end
