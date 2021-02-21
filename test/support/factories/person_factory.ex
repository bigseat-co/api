defmodule Bigseat.Factory.PersonFactory do
  use ExMachina.Ecto, repo: Bigseat.Repo
  alias Bigseat.Factory.OrganizationFactory

  def person_factory do
    %Bigseat.Core.Person{
      organization: OrganizationFactory.build(:organization),
      email: "test@test.com",
      first_name: "Laurent",
      last_name: "Schaffner",
      encrypted_password: Comeonin.Bcrypt.hashpwsalt("password"),
      api_key: :crypto.strong_rand_bytes(64) |> Base.url_encode64,
      type: "TeamMember"
    }
  end

  def people_password_token_factory do
    %Bigseat.Core.PeoplePasswordToken{
      person: build(:person),
      token: "random-token"
    }
  end
end
