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

  def create(space, person_params = %{email: email, first_name: first_name, last_name: last_name}, params = %{start_at: start_at, end_at: end_at}) do
    bookings_count = Booking |> Booking.range(start_at, end_at) |> Repo.aggregate(:count, :id)

    with {:ok} <- capacity_not_reached?(space, start_at, end_at),
         {:ok, person} <- find_or_create_person(space.organization_id, person_params) do
          booking = %Booking{}
          |> Booking.create_changeset(params)
          |> Ecto.Changeset.put_assoc(:space, space)
          |> Ecto.Changeset.put_assoc(:person, person)
          |> Repo.insert()

          booking
    end
  end

  defp find_or_create_person(organization_id, params = %{email: email, first_name: first_name, last_name: last_name}) do
    person = Person |> where(email: ^email) |> where(organization_id: ^organization_id) |> Repo.one()
    case person do
      %Person{} -> {:ok, person}
      _ ->
        organization = Organization |> Repo.get!(organization_id)
        guest = %Person{}
        |> Person.create_changeset(Map.merge(params, %{is_admin: false, type: "Guest", group: :remote}))
        |> Ecto.Changeset.put_assoc(:organization, organization)
        |> Repo.insert()

        {:ok, guest}
    end
  end

  defp capacity_not_reached?(space, start_at, end_at) do
    bookings_count = Booking |> Booking.range(start_at, end_at) |> Repo.aggregate(:count, :id)
    if bookings_count >= space.maximum_people do
      {:error, "maximum people reached for this space (#{space.maximum_people})"}
    else
      {:ok}
    end
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
