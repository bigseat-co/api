defmodule Bigseat.DashboardTest do
  use Bigseat.DataCase

  alias Bigseat.Dashboard

  describe "spaces" do
    alias Bigseat.Dashboard.Space

    @valid_attrs %{avatar_url: "some avatar_url", name: "some name", open_hours: %{}, slug: "some slug", working_days: %{}}
    @update_attrs %{avatar_url: "some updated avatar_url", name: "some updated name", open_hours: %{}, slug: "some updated slug", working_days: %{}}
    @invalid_attrs %{avatar_url: nil, name: nil, open_hours: nil, slug: nil, working_days: nil}

    def space_fixture(attrs \\ %{}) do
      {:ok, space} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Dashboard.create_space()

      space
    end

    test "list_spaces/0 returns all spaces" do
      space = space_fixture()
      assert Dashboard.list_spaces() == [space]
    end

    test "get_space!/1 returns the space with given id" do
      space = space_fixture()
      assert Dashboard.get_space!(space.id) == space
    end

    test "create_space/1 with valid data creates a space" do
      assert {:ok, %Space{} = space} = Dashboard.create_space(@valid_attrs)
      assert space.avatar_url == "some avatar_url"
      assert space.name == "some name"
      assert space.open_hours == %{}
      assert space.slug == "some slug"
      assert space.working_days == %{}
    end

    test "create_space/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Dashboard.create_space(@invalid_attrs)
    end

    test "update_space/2 with valid data updates the space" do
      space = space_fixture()
      assert {:ok, %Space{} = space} = Dashboard.update_space(space, @update_attrs)
      assert space.avatar_url == "some updated avatar_url"
      assert space.name == "some updated name"
      assert space.open_hours == %{}
      assert space.slug == "some updated slug"
      assert space.working_days == %{}
    end

    test "update_space/2 with invalid data returns error changeset" do
      space = space_fixture()
      assert {:error, %Ecto.Changeset{}} = Dashboard.update_space(space, @invalid_attrs)
      assert space == Dashboard.get_space!(space.id)
    end

    test "delete_space/1 deletes the space" do
      space = space_fixture()
      assert {:ok, %Space{}} = Dashboard.delete_space(space)
      assert_raise Ecto.NoResultsError, fn -> Dashboard.get_space!(space.id) end
    end

    test "change_space/1 returns a space changeset" do
      space = space_fixture()
      assert %Ecto.Changeset{} = Dashboard.change_space(space)
    end
  end

  describe "organizations" do
    alias Bigseat.Dashboard.Organization

    @valid_attrs %{name: "some name", slug: "some slug"}
    @update_attrs %{name: "some updated name", slug: "some updated slug"}
    @invalid_attrs %{name: nil, slug: nil}

    def organization_fixture(attrs \\ %{}) do
      {:ok, organization} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Dashboard.create_organization()

      organization
    end

    test "list_organizations/0 returns all organizations" do
      organization = organization_fixture()
      assert Dashboard.list_organizations() == [organization]
    end

    test "get_organization!/1 returns the organization with given id" do
      organization = organization_fixture()
      assert Dashboard.get_organization!(organization.id) == organization
    end

    test "create_organization/1 with valid data creates a organization" do
      assert {:ok, %Organization{} = organization} = Dashboard.create_organization(@valid_attrs)
      assert organization.name == "some name"
      assert organization.slug == "some slug"
    end

    test "create_organization/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Dashboard.create_organization(@invalid_attrs)
    end

    test "update_organization/2 with valid data updates the organization" do
      organization = organization_fixture()
      assert {:ok, %Organization{} = organization} = Dashboard.update_organization(organization, @update_attrs)
      assert organization.name == "some updated name"
      assert organization.slug == "some updated slug"
    end

    test "update_organization/2 with invalid data returns error changeset" do
      organization = organization_fixture()
      assert {:error, %Ecto.Changeset{}} = Dashboard.update_organization(organization, @invalid_attrs)
      assert organization == Dashboard.get_organization!(organization.id)
    end

    test "delete_organization/1 deletes the organization" do
      organization = organization_fixture()
      assert {:ok, %Organization{}} = Dashboard.delete_organization(organization)
      assert_raise Ecto.NoResultsError, fn -> Dashboard.get_organization!(organization.id) end
    end

    test "change_organization/1 returns a organization changeset" do
      organization = organization_fixture()
      assert %Ecto.Changeset{} = Dashboard.change_organization(organization)
    end
  end
end
