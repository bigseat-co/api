defmodule Bigseat.Schema.Dashboard.ForgotMyPassword do
  use Absinthe.Schema.Notation
  alias Crudry.Middlewares.TranslateErrors

  object :dashboard_forgot_my_password do
    @desc "Request a password reset by email"
    field :forgot_my_password, :person do
      arg :email, non_null(:string)

      resolve &resolve/3
      middleware TranslateErrors
    end
  end

  def resolve(_parent, %{ email: email }, _resolution) do
    Bigseat.Dashboard.PeoplePasswordTokens.request_new_password_by_email(email)
  end

  def resolve(_parent, _args, _resolution) do
    {:error, "not found"}
  end
end
