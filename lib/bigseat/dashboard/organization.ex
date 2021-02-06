defmodule Bigseat.Dashboard.Organization do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "organizations" do
    has_many :spaces, Bigseat.Dashboard.Space
    has_many :identities, Bigseat.Dashboard.Identity
    field :name, :string
    field :slug, :string

    timestamps()
  end

  @doc false
  def changeset(organization, attrs) do
    organization
    |> cast(attrs, [:slug, :name])
    |> validate_required([:slug, :name])
    |> unique_constraint(:slug)
  end
end
