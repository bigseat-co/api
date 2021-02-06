defmodule Bigseat.Factory do
  use ExMachina.Ecto, repo: Bigseat.Repo

  def organization_factory do
    %Bigseat.Core.Organization{
      name: "Random name too",
      slug: "random-slug-too"
    }
  end

  def space_factory do
    %Bigseat.Core.Space{
      organization: build(:organization),
      avatar_url: "http://fake-avatar.com",
      name: "Random name",
      slug: "random-slug",
      working_days: %{"test" => true},
      open_hours: %{"test" => true}
    }
  end
end