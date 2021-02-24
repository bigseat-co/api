defmodule Bigseat.Factory.OrganizationFactory do
  use ExMachina.Ecto, repo: Bigseat.Repo

  def organization_factory do
    %Bigseat.Core.Organization{
      name: Faker.Pokemon.location()
    }
  end
end
