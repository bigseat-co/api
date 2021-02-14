defmodule Bigseat.Dashboard.Person do
  import Ecto.Query, warn: false
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
    field :type, :string
    field :is_admin, :boolean, default: false
    field :last_name, :string
    field :api_key, :string

    timestamps()
  end

  def changeset(person, attrs) do
    person
    |> cast(attrs, [:email, :password, :first_name, :last_name, :is_admin, :type, :group, :api_key])
    |> cast_assoc(:organization)
    |> put_api_key()
    |> validate_required([:email, :first_name, :last_name, :api_key, :type, :group])
    |> unique_constraint(:email, name: :people_organization_id_email_index)
    |> validate_unique_admin()
    |> put_encrypted_password()
  end

  defp validate_unique_admin(changeset) do
    email = Map.get(changeset.changes, :email)
    query = from person in Bigseat.Dashboard.Person, where: person.email == ^email, where: person.is_admin == true

    case Bigseat.Repo.exists?(query) == false do
      true -> changeset
      false -> add_error(changeset, :email, "already in use within another organization")
    end
  end

  defp put_encrypted_password(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        put_change(changeset, :encrypted_password, Comeonin.Bcrypt.hashpwsalt(password))
      _ ->
        changeset
    end
  end

  defp put_api_key(changeset) do
    api_key = :crypto.strong_rand_bytes(64) |> Base.url_encode64
    put_change(changeset, :api_key, api_key)
  end
end
