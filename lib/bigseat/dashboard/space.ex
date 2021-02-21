defmodule Bigseat.Dashboard.Space do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "spaces" do
    belongs_to :organization, Bigseat.Dashboard.Organization
    has_many :open_hours, Bigseat.Dashboard.SpaceOpenHour
    field :avatar_url, :string
    field :name, :string
    field :slug, :string
    field :maximum_people, :integer

    timestamps()
  end

  def create_changeset(space, attrs) do
    space
    |> cast(attrs, [:slug, :name, :avatar_url, :maximum_people, :organization_id])
    |> cast_assoc(:open_hours)
    |> put_slug()
    |> validate_required([:slug, :name, :avatar_url, :maximum_people, :organization_id])
    |> unique_constraint(:slug, [:organization_id, :slug])
  end

  def update_changeset(space, attrs) do
    space
    |> cast(attrs, [:name, :avatar_url, :maximum_people])
    |> cast_assoc(:open_hours)
  end

  defp put_slug(changeset) do
    case changeset.changes do
    %{slug: _} ->
      changeset
    _ ->
      put_change(changeset, :slug, Bigseat.Dashboard.Space.Helper.slug_with(changeset.changes))
    end
  end
end

defmodule Bigseat.Dashboard.Space.Helper do
  import Ecto.Query, warn: false

  def slug_with(params = %{name: name, organization_id: organization_id}, iteration \\ 0) do
    raw_slug = Inflex.parameterize(name)
    end_slug = if iteration === 0 do
      raw_slug
    else
      "#{raw_slug}#{iteration}"
    end

    query = from space in Bigseat.Dashboard.Space,
            where: space.slug == ^end_slug,
            where: space.organization_id == ^organization_id

    if Bigseat.Repo.exists?(query) do
      slug_with(params, iteration+1)
    else
      end_slug
    end
  end
end
