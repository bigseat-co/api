defmodule Bigseat.Dashboard.PeopleTest do
  use Bigseat.DataCase
  import Bigseat.Factory

  describe "people" do
    alias Bigseat.Dashboard.Person
    alias Bigseat.Dashboard.People

    @valid_attrs %{}
    @update_attrs %{email: "some updated email", password: "some updated password", first_name: "some updated first_name", group: "some updated group", is_admin: false, last_name: "some updated last_name"}
    @invalid_attrs %{email: nil, password: nil, first_name: nil, group: nil, is_admin: nil, last_name: nil}

    test "list/0 returns all people" do
      person = insert(:person)
      people_list = Enum.map(People.list, fn person -> person.id end)
      assert people_list == [person.id]
    end

    test "get!/1 returns the person with given id" do
      person = person_factory()
      assert People.get!(person.id) == person
    end

    test "create/1 with valid data creates a person" do
      assert {:ok, %Person{} = person} = People.create(@valid_attrs)
      assert person.email == "some email"
      assert person.encrypted_password == "some encrypted_password"
      assert person.first_name == "some first_name"
      assert person.group == "some group"
      assert person.is_admin == true
      assert person.last_name == "some last_name"
    end

    test "create/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = People.create(@invalid_attrs)
    end

    test "update/2 with valid data updates the person" do
      person = person_factory()
      assert {:ok, %Person{} = person} = People.update(person, @update_attrs)
      assert person.email == "some updated email"
      assert person.encrypted_password == "some updated encrypted_password"
      assert person.first_name == "some updated first_name"
      assert person.group == "some updated group"
      assert person.is_admin == false
      assert person.last_name == "some updated last_name"
    end

    test "update/2 with invalid data returns error changeset" do
      person = person_factory()
      assert {:error, %Ecto.Changeset{}} = People.update(person, @invalid_attrs)
      assert person == People.get!(person.id)
    end

    test "delete/1 deletes the person" do
      person = person_factory()
      assert {:ok, %Person{}} = People.delete(person)
      assert_raise Ecto.NoResultsError, fn -> People.get!(person.id) end
    end

    test "change/1 returns a person changeset" do
      person = person_factory()
      assert %Ecto.Changeset{} = People.change(person)
    end
  end
end
