defmodule Bigseat.Schema.Dashboard.CreateSpace do
  use Absinthe.Schema.Notation

  object :dashboard_create_space do
    @desc "Create a new space"
    field :create_space, :space do
      arg :avatar_url, :string
      arg :slug, :string
      arg :name, non_null(:string)
      arg :open_hours, list_of(non_null(:open_hours_input))
      arg :maximum_people, non_null(:integer)

      middleware BigseatWeb.Middleware.Authorized
      resolve fn _parent, args, %{ context: %{ current_person: current_person }} ->
        Bigseat.Dashboard.Spaces.create(args, current_person)
      end
    end
  end

  input_object :open_hours_input do
    field :day_of_the_week, non_null(:string)
    field :open_time, non_null(:time) # ISO 8601
    field :close_time, non_null(:time) # ISO 8601
  end
end
