defmodule Bigseat.Schema do
  use Absinthe.Schema

  import_types Bigseat.Schema.Scalars.Json
  import_types Bigseat.Schema.Scalars.Uuid

  import_types Bigseat.Schema.Dashboard.Types
  import_types Bigseat.Schema.Dashboard.Queries.Spaces
  import_types Bigseat.Schema.Dashboard.Mutations.Signup

  query do
    import_fields :dashboard_queries
  end

  mutation do
    import_fields :dashboard_mutations_signup
  end
end
