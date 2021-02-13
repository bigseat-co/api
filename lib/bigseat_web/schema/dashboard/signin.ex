defmodule Bigseat.Schema.Dashboard.Signin do
  use Absinthe.Schema.Notation
  alias Crudry.Middlewares.TranslateErrors
  alias Bigseat.Schema.Dashboard.Mutations.Signin.Helper

  object :dashboard_signin do
    @desc "Signin to the dashboard"
    field :signin, :person do
      arg :email, non_null(:string)
      arg :password, non_null(:string)

      resolve fn _parent, %{email: email, password: password}, _resolution ->
        Helper.signin_with_email_password(email, password)
      end
      middleware TranslateErrors
    end
  end
end

defmodule Bigseat.Schema.Dashboard.Mutations.Signin.Helper do
  import Comeonin.Bcrypt, only: [checkpw: 2]
  alias Bigseat.Repo
  alias Bigseat.Dashboard.Person

  def signin_with_email_password(email, given_password) do
    person = Person |> Repo.get_by(email: String.downcase(email)) |> Repo.preload(:organization)

    cond do
      person && checkpw(given_password, person.encrypted_password) -> {:ok, person}
      person -> {:error, "Incorrect signin credentials"}
      true -> {:error, :"Person not found"}
    end
  end
end
