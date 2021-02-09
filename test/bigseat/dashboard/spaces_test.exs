defmodule Bigseat.Dashboard.SpacesTest do
  use Bigseat.DataCase

  describe "spaces" do
    alias Bigseat.Dashboard.Space
    alias Bigseat.Dashboard.Spaces

    @valid_attrs %{avatar_url: "some avatar_url", name: "some name", open_hours: %{}, slug: "some slug", working_days: %{}}
    @update_attrs %{avatar_url: "some updated avatar_url", name: "some updated name", open_hours: %{}, slug: "some updated slug", working_days: %{}}
    @invalid_attrs %{avatar_url: nil, name: nil, open_hours: nil, slug: nil, working_days: nil}

    def space_fixture(attrs \\ %{}) do
      {:ok, space} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Spaces.create()

      space
    end

    test "lists/0 returns all spaces" do
      space = space_fixture()
      assert Spaces.lists() == [space]
    end

    test "get!/1 returns the space with given id" do
      space = space_fixture()
      assert Spaces.get!(space.id) == space
    end

    test "create/1 with valid data creates a space" do
      assert {:ok, %Space{} = space} = Spaces.create(@valid_attrs)
      assert space.avatar_url == "some avatar_url"
      assert space.name == "some name"
      assert space.open_hours == %{}
      assert space.slug == "some slug"
      assert space.working_days == %{}
    end

    test "create/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Spaces.create(@invalid_attrs)
    end

    test "update/2 with valid data updates the space" do
      space = space_fixture()
      assert {:ok, %Space{} = space} = Spaces.update(space, @update_attrs)
      assert space.avatar_url == "some updated avatar_url"
      assert space.name == "some updated name"
      assert space.open_hours == %{}
      assert space.slug == "some updated slug"
      assert space.working_days == %{}
    end

    test "update/2 with invalid data returns error changeset" do
      space = space_fixture()
      assert {:error, %Ecto.Changeset{}} = Spaces.update(space, @invalid_attrs)
      assert space == Spaces.get!(space.id)
    end

    test "delete/1 deletes the space" do
      space = space_fixture()
      assert {:ok, %Space{}} = Spaces.delete(space)
      assert_raise Ecto.NoResultsError, fn -> Spaces.get!(space.id) end
    end

    test "change/1 returns a space changeset" do
      space = space_fixture()
      assert %Ecto.Changeset{} = Spaces.change(space)
    end
  end
end
