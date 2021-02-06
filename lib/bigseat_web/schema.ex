defmodule Bigseat.Schema do
  use Absinthe.Schema

  import_types Bigseat.Schema.Scalars.Json
  import_types Bigseat.Schema.Scalars.Uuid

  import_types Bigseat.Schema.Dashboard.Types
  import_types Bigseat.Schema.Dashboard.Queries

  query do
    import_fields :space_queries
  end
end
