defmodule Bigseat.Schema.Dashboard.ChangePasswordFromToken do
  use Absinthe.Schema.Notation
  alias Crudry.Middlewares.TranslateErrors

  object :dashboard_change_password_from_token do
    @desc "Change password from specific token"
    field :change_password_from_token, :person do
      arg :token, non_null(:string)
      arg :new_password, non_null(:string)

      resolve fn _parent, %{ token: token, new_password: new_password }, _resolution ->
        Bigseat.Dashboard.PeoplePasswordTokens.confirm_new_password(token, new_password)
      end
      middleware TranslateErrors
    end
  end
end
