defmodule Bigseat.Dashboard.People do

  import Ecto.Query, warn: false
  alias Bigseat.Repo

  alias Bigseat.Dashboard.Person

  def list do
    Repo.all(Person)
  end

  def get!(id), do: Repo.get!(Person, id)

  def create(attrs \\ %{}) do
    %Person{}
    |> Person.changeset(attrs)
    |> Repo.insert()
  end

  def update(%Person{} = person, attrs) do
    person
    |> Person.changeset(attrs)
    |> Repo.update()
  end

  def delete(%Person{} = person) do
    Repo.delete(person)
  end

  def change(%Person{} = person, attrs \\ %{}) do
    Person.changeset(person, attrs)
  end
end
