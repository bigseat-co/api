defmodule Bigseat.Factory.SpaceFactory do
  use ExMachina.Ecto, repo: Bigseat.Repo
  alias Bigseat.Factory.{
    OrganizationFactory
  }

  def space_factory do
    %Bigseat.Core.Space{
      organization: OrganizationFactory.build(:organization),
      avatar_url: "http://fake-avatar.com",
      name: Faker.Pokemon.location(),
      maximum_people: 10,
      open_hours: [build(:space_open_hour)]
    }
  end

  def space_open_hour_factory do
    %Bigseat.Core.SpaceOpenHour{
      # space: build(:space),
      day_of_the_week: "monday",
      open_time: "10:00:00Z",
      close_time: "18:00:00Z"
    }
  end

  # def space_with_bookings_factory do
  #   Map.merge(space_factory(), %{
  #     bookings: [BookingFactory.insert(:booking)]
  #   })
  # end
end
