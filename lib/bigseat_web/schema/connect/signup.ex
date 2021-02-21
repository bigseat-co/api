defmodule Bigseat.Schema.Connect.Signup do
  use Absinthe.Schema.Notation
  alias Crudry.Middlewares.TranslateErrors

  object :connect_signup do
    @desc "Signup to the dashboard"
    field :signup, :person do
      arg :first_name, non_null(:string)
      arg :last_name, non_null(:string)
      arg :email, non_null(:string)
      arg :password, non_null(:string)
      arg :organization, non_null(:organization_input)

      resolve &resolve/3
      middleware TranslateErrors
    end
  end

  input_object :organization_input do
    field :name, non_null(:string)
    field :slug, :string
  end

  def resolve(_parent, args, _resolution) do
    Bigseat.Dashboard.People.create_from_scratch(args)
  end
end
