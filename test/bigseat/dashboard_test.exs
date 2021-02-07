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
        |> Dashboard.create()

      space
    end

    test "lists/0 returns all spaces" do
      space = space_fixture()
      assert Dashboard.lists() == [space]
    end

    test "get!/1 returns the space with given id" do
      space = space_fixture()
      assert Dashboard.get!(space.id) == space
    end

    test "create/1 with valid data creates a space" do
      assert {:ok, %Space{} = space} = Dashboard.create(@valid_attrs)
      assert space.avatar_url == "some avatar_url"
      assert space.name == "some name"
      assert space.open_hours == %{}
      assert space.slug == "some slug"
      assert space.working_days == %{}
    end

    test "create/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Dashboard.create(@invalid_attrs)
    end

    test "update/2 with valid data updates the space" do
      space = space_fixture()
      assert {:ok, %Space{} = space} = Dashboard.update(space, @update_attrs)
      assert space.avatar_url == "some updated avatar_url"
      assert space.name == "some updated name"
      assert space.open_hours == %{}
      assert space.slug == "some updated slug"
      assert space.working_days == %{}
    end

    test "update/2 with invalid data returns error changeset" do
      space = space_fixture()
      assert {:error, %Ecto.Changeset{}} = Dashboard.update(space, @invalid_attrs)
      assert space == Dashboard.get!(space.id)
    end

    test "delete/1 deletes the space" do
      space = space_fixture()
      assert {:ok, %Space{}} = Dashboard.delete(space)
      assert_raise Ecto.NoResultsError, fn -> Dashboard.get!(space.id) end
    end

    test "change/1 returns a space changeset" do
      space = space_fixture()
      assert %Ecto.Changeset{} = Dashboard.change(space)
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
        |> Dashboard.create()

      organization
    end

    test "list/0 returns all organizations" do
      organization = organization_fixture()
      assert Dashboard.list() == [organization]
    end

    test "get_organization!/1 returns the organization with given id" do
      organization = organization_fixture()
      assert Dashboard.get_organization!(organization.id) == organization
    end

    test "create/1 with valid data creates a organization" do
      assert {:ok, %Organization{} = organization} = Dashboard.create(@valid_attrs)
      assert organization.name == "some name"
      assert organization.slug == "some slug"
    end

    test "create/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Dashboard.create(@invalid_attrs)
    end

    test "update/2 with valid data updates the organization" do
      organization = organization_fixture()
      assert {:ok, %Organization{} = organization} = Dashboard.update(organization, @update_attrs)
      assert organization.name == "some updated name"
      assert organization.slug == "some updated slug"
    end

    test "update/2 with invalid data returns error changeset" do
      organization = organization_fixture()
      assert {:error, %Ecto.Changeset{}} = Dashboard.update(organization, @invalid_attrs)
      assert organization == Dashboard.get_organization!(organization.id)
    end

    test "delete/1 deletes the organization" do
      organization = organization_fixture()
      assert {:ok, %Organization{}} = Dashboard.delete(organization)
      assert_raise Ecto.NoResultsError, fn -> Dashboard.get_organization!(organization.id) end
    end

    test "change/1 returns a organization changeset" do
      organization = organization_fixture()
      assert %Ecto.Changeset{} = Dashboard.change(organization)
    end
  end

  describe "people" do
    alias Bigseat.Dashboard.Person

    @valid_attrs %{email: "some email", encrypted_password: "some encrypted_password", first_name: "some first_name", group: "some group", is_admin: true, last_name: "some last_name"}
    @update_attrs %{email: "some updated email", encrypted_password: "some updated encrypted_password", first_name: "some updated first_name", group: "some updated group", is_admin: false, last_name: "some updated last_name"}
    @invalid_attrs %{email: nil, encrypted_password: nil, first_name: nil, group: nil, is_admin: nil, last_name: nil}

    def person_fixture(attrs \\ %{}) do
      {:ok, person} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Dashboard.create()

      person
    end

    test "list/0 returns all people" do
      person = person_fixture()
      assert Dashboard.list() == [person]
    end

    test "get!/1 returns the person with given id" do
      person = person_fixture()
      assert Dashboard.get!(person.id) == person
    end

    test "create/1 with valid data creates a person" do
      assert {:ok, %Person{} = person} = Dashboard.create(@valid_attrs)
      assert person.email == "some email"
      assert person.encrypted_password == "some encrypted_password"
      assert person.first_name == "some first_name"
      assert person.group == "some group"
      assert person.is_admin == true
      assert person.last_name == "some last_name"
    end

    test "create/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Dashboard.create(@invalid_attrs)
    end

    test "update/2 with valid data updates the person" do
      person = person_fixture()
      assert {:ok, %Person{} = person} = Dashboard.update(person, @update_attrs)
      assert person.email == "some updated email"
      assert person.encrypted_password == "some updated encrypted_password"
      assert person.first_name == "some updated first_name"
      assert person.group == "some updated group"
      assert person.is_admin == false
      assert person.last_name == "some updated last_name"
    end

    test "update/2 with invalid data returns error changeset" do
      person = person_fixture()
      assert {:error, %Ecto.Changeset{}} = Dashboard.update(person, @invalid_attrs)
      assert person == Dashboard.get!(person.id)
    end

    test "delete/1 deletes the person" do
      person = person_fixture()
      assert {:ok, %Person{}} = Dashboard.delete(person)
      assert_raise Ecto.NoResultsError, fn -> Dashboard.get!(person.id) end
    end

    test "change/1 returns a person changeset" do
      person = person_fixture()
      assert %Ecto.Changeset{} = Dashboard.change(person)
    end
  end
end
