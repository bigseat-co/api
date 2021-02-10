defmodule Bigseat.Dashboard.PeopleTest do
  use Bigseat.DataCase
  import Bigseat.Factory

  describe "people" do
    alias Bigseat.Dashboard.People

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
