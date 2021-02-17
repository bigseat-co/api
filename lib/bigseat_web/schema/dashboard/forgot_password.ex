defmodule Bigseat.Schema.Dashboard.ForgotPassword do
  use Absinthe.Schema.Notation
  alias Crudry.Middlewares.TranslateErrors

  object :dashboard_forgot_password do
    @desc "Request a password reset by email"
    field :forgot_password, :person do
      arg :email, non_null(:string)

      resolve fn _parent, %{ email: email }, _resolution ->
        Bigseat.Dashboard.People.request_new_password_by_email(email)
      end
      middleware TranslateErrors
    end
  end
end
