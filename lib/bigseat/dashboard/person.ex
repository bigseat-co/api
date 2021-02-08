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
    |> cast_assoc(:organization)
    |> validate_required([:email, :first_name, :last_name])
  end
end
