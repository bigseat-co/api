defmodule Bigseat.Core.Booking do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "bookings" do
    belongs_to :person, Bigseat.Core.Person
    belongs_to :space, Bigseat.Core.Space
    field :start_at, :utc_datetime
    field :end_at, :utc_datetime

    timestamps()
  end

  def create_changeset(booking, attrs) do
    booking
    |> cast(attrs, [:start_at, :end_at])
    |> cast_assoc(:person)
    |> cast_assoc(:space)
    |> validate_required([:start_at, :end_at])
  end

  def update_changeset(space, attrs) do
    space
    |> cast(attrs, [:start_at, :end_at])
    |> cast_assoc(:person)
    |> cast_assoc(:space)
  end
end
