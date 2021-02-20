defmodule Bigseat.Schema.Dashboard.EditMyAccount do
  use Absinthe.Schema.Notation
  alias Crudry.Middlewares.TranslateErrors

  object :dashboard_edit_my_account do
    @desc "Edit my account"
    field :edit_my_account, :person do
      arg :first_name, :string
      arg :last_name, :string
      arg :email, :string
      arg :password, :string

      middleware BigseatWeb.Middleware.AuthorizedAdmin
      resolve fn _parent, args, %{ context: %{ current_person: current_person }} ->
        Bigseat.Dashboard.People.update(current_person, args)
      end
      middleware TranslateErrors
    end
  end
end
