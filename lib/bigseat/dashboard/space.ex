defmodule Bigseat.Dashboard.Space do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "spaces" do
    belongs_to :organization, Bigseat.Dashboard.Organization
    has_many :open_hours, Bigseat.Dashboard.OrganizationOpenHours
    field :avatar_url, :string
    field :name, :string
    field :slug, :string

    timestamps()
  end

  def changeset(space, attrs) do
    space
    |> cast(attrs, [:slug, :name, :avatar_url])
    |> validate_required([:slug, :name, :avatar_url])
    |> unique_constraint(:slug, [:organization_id, :slug])
  end
end
