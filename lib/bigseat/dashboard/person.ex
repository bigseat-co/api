defmodule Bigseat.Dashboard.Person do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "people" do
    belongs_to :organization, Bigseat.Dashboard.Organization
    field :email, :string
    field :password, :string, virtual: true
    field :encrypted_password, :string
    field :first_name, :string
    field :group, :string
    field :is_admin, :boolean, default: false
    field :last_name, :string

    timestamps()
  end

  @doc false
  def changeset(person, attrs) do
    person
    |> cast(attrs, [:email, :encrypted_password, :first_name, :last_name, :is_admin, :group])
    |> validate_required([:organization, :email, :first_name, :last_name])
    |> unique_constraint(:slug, [:organization_id, :slug])
    |> unique_constraint(:email, [:organization_id, :email])
  end
end
