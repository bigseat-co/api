defmodule Bigseat.Dashboard do
  @moduledoc """
  The Dashboard context.
  """

  import Ecto.Query, warn: false
  alias Bigseat.Repo

  alias Bigseat.Dashboard.Space

  @doc """
  Returns the list of spaces.

  ## Examples

      iex> list_spaces()
      [%Space{}, ...]

  """
  def list_spaces do
    Repo.all(Space)
  end

  @doc """
  Gets a single space.

  Raises `Ecto.NoResultsError` if the Space does not exist.

  ## Examples

      iex> get_space!(123)
      %Space{}

      iex> get_space!(456)
      ** (Ecto.NoResultsError)

  """
  def get_space!(id), do: Repo.get!(Space, id)

  @doc """
  Creates a space.

  ## Examples

      iex> create_space(%{field: value})
      {:ok, %Space{}}

      iex> create_space(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_space(attrs \\ %{}) do
    %Space{}
    |> Space.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a space.

  ## Examples

      iex> update_space(space, %{field: new_value})
      {:ok, %Space{}}

      iex> update_space(space, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_space(%Space{} = space, attrs) do
    space
    |> Space.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a space.

  ## Examples

      iex> delete_space(space)
      {:ok, %Space{}}

      iex> delete_space(space)
      {:error, %Ecto.Changeset{}}

  """
  def delete_space(%Space{} = space) do
    Repo.delete(space)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking space changes.

  ## Examples

      iex> change_space(space)
      %Ecto.Changeset{data: %Space{}}

  """
  def change_space(%Space{} = space, attrs \\ %{}) do
    Space.changeset(space, attrs)
  end

  alias Bigseat.Dashboard.Organization

  @doc """
  Returns the list of organizations.

  ## Examples

      iex> list_organizations()
      [%Organization{}, ...]

  """
  def list_organizations do
    Repo.all(Organization)
  end

  @doc """
  Gets a single organization.

  Raises `Ecto.NoResultsError` if the Organization does not exist.

  ## Examples

      iex> get_organization!(123)
      %Organization{}

      iex> get_organization!(456)
      ** (Ecto.NoResultsError)

  """
  def get_organization!(id), do: Repo.get!(Organization, id)

  @doc """
  Creates a organization.

  ## Examples

      iex> create_organization(%{field: value})
      {:ok, %Organization{}}

      iex> create_organization(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_organization(attrs \\ %{}) do
    %Organization{}
    |> Organization.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a organization.

  ## Examples

      iex> update_organization(organization, %{field: new_value})
      {:ok, %Organization{}}

      iex> update_organization(organization, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_organization(%Organization{} = organization, attrs) do
    organization
    |> Organization.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a organization.

  ## Examples

      iex> delete_organization(organization)
      {:ok, %Organization{}}

      iex> delete_organization(organization)
      {:error, %Ecto.Changeset{}}

  """
  def delete_organization(%Organization{} = organization) do
    Repo.delete(organization)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking organization changes.

  ## Examples

      iex> change_organization(organization)
      %Ecto.Changeset{data: %Organization{}}

  """
  def change_organization(%Organization{} = organization, attrs \\ %{}) do
    Organization.changeset(organization, attrs)
  end

  alias Bigseat.Dashboard.Identity

  @doc """
  Returns the list of identities.

  ## Examples

      iex> list_identities()
      [%Identity{}, ...]

  """
  def list_identities do
    Repo.all(Identity)
  end

  @doc """
  Gets a single identity.

  Raises `Ecto.NoResultsError` if the Identity does not exist.

  ## Examples

      iex> get_identity!(123)
      %Identity{}

      iex> get_identity!(456)
      ** (Ecto.NoResultsError)

  """
  def get_identity!(id), do: Repo.get!(Identity, id)

  @doc """
  Creates a identity.

  ## Examples

      iex> create_identity(%{field: value})
      {:ok, %Identity{}}

      iex> create_identity(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_identity(attrs \\ %{}) do
    %Identity{}
    |> Identity.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a identity.

  ## Examples

      iex> update_identity(identity, %{field: new_value})
      {:ok, %Identity{}}

      iex> update_identity(identity, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_identity(%Identity{} = identity, attrs) do
    identity
    |> Identity.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a identity.

  ## Examples

      iex> delete_identity(identity)
      {:ok, %Identity{}}

      iex> delete_identity(identity)
      {:error, %Ecto.Changeset{}}

  """
  def delete_identity(%Identity{} = identity) do
    Repo.delete(identity)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking identity changes.

  ## Examples

      iex> change_identity(identity)
      %Ecto.Changeset{data: %Identity{}}

  """
  def change_identity(%Identity{} = identity, attrs \\ %{}) do
    Identity.changeset(identity, attrs)
  end
end
