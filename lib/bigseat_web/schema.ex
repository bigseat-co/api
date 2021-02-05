defmodule Bigseat.Schema do
  use Absinthe.Schema

  import_types Bigseat.Schema.Scalars
  import_types Bigseat.Schema.Core.Types
  import_types Bigseat.Schema.Core.Queries

  query do
    import_fields :space_queries
  end
end
