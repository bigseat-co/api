defmodule Bigseat.Factory do
  use ExMachina.Ecto, repo: Bigseat.Repo

  def organization_factory do
    %Bigseat.Dashboard.Organization{
      name: "Random name too"
    }
  end

  def space_factory do
    %Bigseat.Dashboard.Space{
      organization: build(:organization),
      avatar_url: "http://fake-avatar.com",
      name: "Random name",
      slug: "random-slug",
      open_hours: [build(:space_open_hour)]
    }
  end

  def person_factory do
    %Bigseat.Dashboard.Person{
      organization: build(:organization),
      email: "test@test.com",
      first_name: "Laurent",
      last_name: "Schaffner",
      encrypted_password: Comeonin.Bcrypt.hashpwsalt("password"),
      api_key: "valid-api-key",
      type: "TeamMember"
    }
  end

  def space_open_hour_factory do
    %Bigseat.Dashboard.SpaceOpenHour{
      # space: build(:space),
      day_of_the_week: "monday",
      open_time: "10:00:00Z",
      close_time: "18:00:00Z"
    }
  end
end
