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
      arg :organization, non_null(:organization_input)

      resolve fn _parent, args, _resolution ->
        Bigseat.Dashboard.People.create(args)
      end
      middleware TranslateErrors
    end
  end

  input_object :organization_input do
    field :name, non_null(:string)
    field :slug, :string
  end
end
