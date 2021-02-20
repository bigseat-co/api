defmodule Bigseat.Schema.Dashboard.EditMyAccount do
  use Absinthe.Schema.Notation
  alias Crudry.Middlewares.TranslateErrors

  object :dashboard_edit_my_account do
    @desc "Edit my account"
    field :edit_my_account, :person do
      arg :first_name, non_null(:string)
      arg :last_name, non_null(:string)
      arg :email, non_null(:string)
      arg :group, non_null(:string)

      middleware BigseatWeb.Middleware.AuthorizedAdmin
      resolve fn _parent, args, %{ context: %{ current_person: current_person }} ->
        Bigseat.Dashboard.People.update(args, current_person.id)
      end
      middleware TranslateErrors
    end
  end
end
