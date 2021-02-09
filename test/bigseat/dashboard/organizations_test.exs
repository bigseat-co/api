defmodule Bigseat.Dashboard.OrganizationsTest do
  use Bigseat.DataCase

  describe "organizations" do
    alias Bigseat.Dashboard.Organization
    alias Bigseat.Dashboard.Organizations

    @valid_attrs %{name: "some name", slug: "some slug"}
    @update_attrs %{name: "some updated name", slug: "some updated slug"}
    @invalid_attrs %{name: nil, slug: nil}

    def organization_fixture(attrs \\ %{}) do
      {:ok, organization} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Organizations.create()

      organization
    end

    test "list/0 returns all organizations" do
      organization = organization_fixture()
      assert Organizations.list() == [organization]
    end

    test "get!/1 returns the organization with given id" do
      organization = organization_fixture()
      assert Organizations.get!(organization.id) == organization
    end

    test "create/1 with valid data creates a organization" do
      assert {:ok, %Organization{} = organization} = Organizations.create(@valid_attrs)
      assert organization.name == "some name"
      assert organization.slug == "some slug"
    end

    test "create/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Organizations.create(@invalid_attrs)
    end

    test "update/2 with valid data updates the organization" do
      organization = organization_fixture()
      assert {:ok, %Organization{} = organization} = Organizations.update(organization, @update_attrs)
      assert organization.name == "some updated name"
      assert organization.slug == "some updated slug"
    end

    test "update/2 with invalid data returns error changeset" do
      organization = organization_fixture()
      assert {:error, %Ecto.Changeset{}} = Organizations.update(organization, @invalid_attrs)
      assert organization == Organizations.get!(organization.id)
    end

    test "delete/1 deletes the organization" do
      organization = organization_fixture()
      assert {:ok, %Organization{}} = Organizations.delete(organization)
      assert_raise Ecto.NoResultsError, fn -> Organizations.get!(organization.id) end
    end

    test "change/1 returns a organization changeset" do
      organization = organization_fixture()
      assert %Ecto.Changeset{} = Organizations.change(organization)
    end
  end
end
