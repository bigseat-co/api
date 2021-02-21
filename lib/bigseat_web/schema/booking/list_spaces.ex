defmodule Bigseat.Schema.Booking.ListSpaces do
  use Absinthe.Schema.Notation
  alias Crudry.Middlewares.TranslateErrors

  object :booking_list_spaces do
    @desc "List spaces by date range and its bookings"
    field :booking_list_spaces, :booking_space do
      arg :start_at, non_null(:string)
      arg :end_at, non_null(:string)

      resolve &resolve/3
      middleware TranslateErrors
    end
  end

  def resolve(_parent, %{ start_at: start_at, end_at: end_at }, _resolution) do
  end

  def resolve(_parent, _args, _resolution) do
    {:error, "not found"}
  end
end
