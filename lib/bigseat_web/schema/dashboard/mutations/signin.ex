defmodule Bigseat.Schema.Dashboard.Mutations.Signin do
  use Absinthe.Schema.Notation
  alias Crudry.Middlewares.TranslateErrors

  object :dashboard_mutations_signin do
    @desc "Signin to the dashboard"
    field :signin, :organization do
      arg :email, non_null(:string)
      arg :password, non_null(:string)

      resolve fn _parent, %{email: email, password: password}, _resolution ->
        with {:ok, person} <- Signin.Helper.signin_with_email_password(email, password) do
             {:ok, %{api_key: person.organization.api_key}}
             end
      end
      middleware TranslateErrors
    end
  end
end

defmodule Signin.Helper do
  import Comeonin.Bcrypt, only: [checkpw: 2]
  alias Bigseat.Repo
  alias Bigseat.Dashboard.Person

  def signin_with_email_password(email, given_password) do
    person = Repo.get_by(Person, email: String.downcase(email)) |> Repo.preload(:organization)

    cond do
      person && checkpw(given_password, person.encrypted_password) -> {:ok, person}
      person -> {:error, "Incorrect signin credentials"}
      true -> {:error, :"Person not found"}
    end
  end
end
