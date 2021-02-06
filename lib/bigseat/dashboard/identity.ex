defmodule Bigseat.Dashboard.Identity do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "identities" do
    belongs_to :organization, Bigseat.Dashboard.Organization
    field :email, :string
    field :encrypted_password, :string
    field :first_name, :string
    field :group, :string
    field :is_admin, :boolean, default: false
    field :last_name, :string

    timestamps()
  end

  @doc false
  def changeset(identity, attrs) do
    identity
    |> cast(attrs, [:email, :encrypted_password, :first_name, :last_name, :is_admin, :group])
    |> validate_required([:email, :encrypted_password, :first_name, :last_name, :is_admin, :group])
    |> unique_constraint(:slug, [:organization_id, :slug])
  end
end
