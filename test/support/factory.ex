defmodule Bigseat.Factory do
  use ExMachina.Ecto, repo: Bigseat.Repo

  def organization_factory do
    %Bigseat.Dashboard.Organization{
      name: "Random name too",
      slug: "random-slug-too"
    }
  end

  def space_factory do
    %Bigseat.Dashboard.Space{
      organization: build(:organization),
      avatar_url: "http://fake-avatar.com",
      name: "Random name",
      slug: "random-slug",
      working_days: %{"test" => true},
      open_hours: %{"test" => true}
    }
  end

  def person_factory do
    %Bigseat.Dashboard.Person{
      organization: build(:organization),
      email: "test@test.com",
      first_name: "Laurent",
      last_name: "Schaffner",
      encrypted_password: "random",
      api_key: "valid-api-key"
    }
  end
end
