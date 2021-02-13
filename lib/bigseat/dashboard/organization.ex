defmodule Bigseat.Dashboard.Organization do
  import Ecto.Query, only: [from: 2]
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "organizations" do
    has_many :spaces, Bigseat.Dashboard.Space
    has_many :people, Bigseat.Dashboard.Person
    field :name, :string
    field :slug, :string

    timestamps()
  end

  @doc false
  def changeset(organization, attrs) do
    organization
    |> cast(attrs, [:name, :slug])
    |> cast_assoc(:people)
    |> put_slug()
    |> validate_required([:name, :slug])
    |> unique_constraint(:slug)
  end

  defp put_slug(changeset) do
    case changeset.changes do
    %{slug: _} ->
      changeset
    _ ->
      put_change(changeset, :slug, Bigseat.Dashboard.Organization.Helper.slug_with(changeset.changes))
    end
  end
end

defmodule Bigseat.Dashboard.Organization.Helper do
  import Ecto.Query, warn: false

  def slug_with(%{name: name}, iteration \\ 0) do
    raw_slug = Slug.slugify(name)
    end_slug = if iteration === 0 do
      raw_slug
    else
      "#{raw_slug}#{iteration}"
    end

    query = from organization in Bigseat.Dashboard.Organization, where: organization.slug == ^end_slug

    if Bigseat.Repo.exists?(query) do
      slug_with(name, iteration+1)
    else
      end_slug
    end
  end
end
