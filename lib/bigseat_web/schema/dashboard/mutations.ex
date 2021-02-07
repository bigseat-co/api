defmodule Bigseat.Schema.Dashboard.Mutations do
  use Absinthe.Schema.Notation
  alias Crudry.Middlewares.TranslateErrors

  object :dashboard_mutations do
    @desc "Signup to the dashboard"
    field :signup, :person do
      arg :first_name, non_null(:string)
      arg :last_name, non_null(:string)
      arg :email, non_null(:string)
      arg :password, non_null(:string)
      arg :organization_name, non_null(:string)

      resolve fn _parent, args, _resolution ->
        Bigseat.Dashboard.People.create(args)
      end
      middleware TranslateErrors
    end
  end
end
