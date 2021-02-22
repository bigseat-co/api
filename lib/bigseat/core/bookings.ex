defmodule Bigseat.Core.Bookings do

  import Ecto.Query, warn: false
  alias Bigseat.Repo

  alias Bigseat.Core.{
    Booking,
    Organization,
    Space,
    Person
  }

  def list_by_space(%Organization{} = organization, start_at, end_at) do
    query = from space in Space,
            join: booking in Booking, on: booking.space_id == space.id,
            join: person in Person, on: booking.person_id == person.id,
            where: space.organization_id == ^organization.id,
            preload: [bookings: {booking, person: person}]

    Repo.all(query)
  end

  def get!(id), do: Repo.get!(Booking, id)

  def create(attrs \\ %{}) do
    %Booking{}
    |> Booking.create_changeset(attrs)
    |> Repo.insert()
  end

  def update(%Booking{} = booking, attrs) do
    booking
    |> Booking.update_changeset(attrs)
    |> Repo.update()
  end

  def delete(%Booking{} = booking) do
    Repo.delete(booking)
  end
end
