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
      person = insert(:person)
      assert People.get!(person.id).id == person.id
    end
  end
end
