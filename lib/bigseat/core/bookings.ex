defmodule Bigseat.Core.Bookings do

  import Ecto.Query, warn: false
  alias Bigseat.Repo

  alias Bigseat.Core.{
    Booking,
    Organization,
    Space,
    Person
  }

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
